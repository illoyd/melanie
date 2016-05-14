##
# Job to poll for mail, passing off to other jobs to parse.
class AddMentionsForContentJob < WithObjectJob

  def perform_with_object(obj)
    Detectors::Binder.new.bind(obj)
  end

end # GetMailJob
