##
# Job to poll for mail, passing off to other jobs to parse.
class AddMentionsForContentJob < ApplicationJob

  def perform(obj)
    Detectors::Binder.new.bind(obj)
  end

end # GetMailJob
