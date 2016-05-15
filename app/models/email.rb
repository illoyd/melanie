##
# Email class, an instance of a Note. Includes additional features for emails.
class Email < Note

  attribute :message_id, :string, validates: { presence: true }
  attribute :subject, :string, validates: { presence: true }

  def sender
    neighbours(Send).first
  end

  def sender?
    sender.present?
  end

  def recipients(type = nil)
    if type.present?
      edges(Receive).select { |receive| receive.type == type }.map { |receive| receive.from }
    else
      neighbours(Receive)
    end
  end

  def recipients?
    recipients.any?
  end

  def to_recipients
    recipients('to'.freeze)
  end

  def to_recipients?
    to_recipients.any?
  end

  def cc_recipients
    recipients('cc'.freeze)
  end

  def cc_recipients?
    cc_recipients.any?
  end

  def bcc_recipients
    recipients('bcc'.freeze)
  end

  def bcc_recipients?
    bcc_recipients.any?
  end

end