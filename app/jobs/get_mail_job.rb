require 'mail'

##
# Job to poll for mail, passing off to other jobs to parse.
class GetMailJob < ApplicationJob

  def perform
    Mail.find( keys: 'TO <melanie@signalcloudapp.com>' ) do |message|
      puts message.sender
      puts message.subject
      puts message.body
    end
  end

end # GetMailJob
