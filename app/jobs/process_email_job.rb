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
    email.created_by = find_or_init_sender(missive)
    email.created_at = missive.date

    # Save people and the email
    email.save!

    # Save the sender edge
    Send.find_or_create_by!('from' => find_or_init_sender(missive), 'to' => email)

    # Save the Receives-TO edge
    find_or_init_people(missive.to_recipients).each do |recipient|
      ToReceive.find_or_create_by!('from' => recipient, 'to' => email)
    end

    # Save the Receives-CC edge
    find_or_init_people(missive.cc_recipients).each do |recipient|
      CcReceive.find_or_create_by!('from' => recipient, 'to' => email)
    end

    # Save the Receives-BCC edge
    find_or_init_people(missive.bcc_recipients).each do |recipient|
      BccReceive.find_or_create_by!('from' => recipient, 'to' => email)
    end

    # Finally, bind the content!
    AddMentionsForContentJob.new.perform(email)
  end

  def find_or_init_person(email, full_name)
    @person_cache[email] ||= Person.find_or_initialize_by(email: email).tap do |person|
      person.full_name ||= full_name || 'Anonymous'
      person.save!
    end
  end

  def find_or_init_person_by_address(address)
    find_or_init_person(address.address, address.display_name || address.name || address.local)
  end

  def find_or_init_people(address_list)
    address_list.each_with_object(Set.new) { |address,list| list << find_or_init_person_by_address(address) }
  end

  def find_or_init_sender(missive)
    find_or_init_person(missive.sender_email, missive.sender_name)
  end

  def find_or_init_email(missive)
    Email.find_or_initialize_by(message_id: missive.message_id).tap do |email|

      # Save the subject and body
      email.subject = missive.subject
      email.body    = missive.body

      # Link the recipients
      people = find_or_init_people(missive.to_recipients)
      email.to_recipients.merge( find_or_init_people(missive.to_recipients) )
      email.cc_recipients.merge( find_or_init_people(missive.cc_recipients) )
      email.bcc_recipients.merge( find_or_init_people(missive.bcc_recipients) )

    end
  end

end # ProcessEmailJob
