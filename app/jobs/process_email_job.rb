require 'mail'

##
# Job to poll for mail, passing off to other jobs to parse.
class ProcessEmailJob < ApplicationJob

  def initialize
    super
    @person_cache = Hash.new
  end

  def perform(missive)

    # Create a new email
    missive = EmailDecorator.new(missive)
    email = find_or_init_email(missive)

    # Update the note creator
    email.created_by = find_or_create_sender(missive)
    email.created_at = missive.date

    # Save people and the email
    email.save!

    # Find and save the sender
    find_or_create_senders(email, missive.senders)

    # Find and save all recipients
    find_or_create_recipients(email, missive.to_recipients, 'to')
    find_or_create_recipients(email, missive.cc_recipients, 'cc')
    find_or_create_recipients(email, missive.bcc_recipients, 'bcc')

    # Finally, bind the content!
    AddMentionsForContentJob.new.perform(email)
  end

  def find_or_create_senders(email, recipients)
    find_or_create_people(recipients).each do |recipient|
      Send.find_or_create_by!('_from' => recipient.document_handle, '_to' => email.document_handle)
    end
  end

  def find_or_create_recipients(email, recipients, type)
    find_or_create_people(recipients).each do |recipient|
      Receive.find_or_create_by!('_from' => recipient.document_handle, '_to' => email.document_handle, 'type' => type)
    end
  end

  def find_or_create_person(email, full_name)
    @person_cache[email] ||= Person.find_or_initialize_by(email: email).tap do |person|
      person.full_name ||= full_name || 'Anonymous'
      person.save!
    end
  end

  def find_or_create_person_by_address(address)
    find_or_create_person(address.address, address.display_name || address.name || address.local)
  end

  def find_or_create_people(address_list)
    address_list.each_with_object(Set.new) { |address,list| list << find_or_create_person_by_address(address) }
  end

  def find_or_create_sender(missive)
    find_or_create_person(missive.sender_email, missive.sender_name)
  end

  def find_or_init_email(missive)
    Email.find_or_initialize_by(message_id: missive.message_id).tap do |email|

      # Save the subject and body
      email.subject = missive.subject
      email.body    = missive.body
      email.created_at = missive.date

    end
  end

end # ProcessEmailJob
