require 'orientdb/orm'

##
# Email class, an instance of a Note. Includes additional features for emails.
class Email < Note
  include Orientdb::ORM::HasEdges

  attribute :message_id, :string, validates: { presence: true }

  attribute :subject, :string, validates: { presence: true }

  def sender
    in_objects(:sends).first
  end

  def sender?
    sender.present?
  end

  def recipients(kind = nil)
    Set.new in_objects(:receives)
  end

  def recipients?
    recipients.any?
  end

  def to_recipients
    Set.new in_objects(:receives_to)
  end

  def to_recipients?
    to_recipients.any?
  end

  def cc_recipients
    Set.new in_objects(:receives_cc)
  end

  def cc_recipients?
    cc_recipients.any?
  end

  def bcc_recipients
    Set.new in_objects(:receives_bcc)
  end

  def bcc_recipients?
    bcc_recipients.any?
  end

end