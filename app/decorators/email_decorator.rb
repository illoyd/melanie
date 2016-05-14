class EmailDecorator < Draper::Decorator
  delegate_all

  ## The sender friendly (display) name
  def sender_name
    object[:from].display_names.first #|| object[:from].
  end

  ## The sender email
  def sender_email
    object.from.first
  end

  ## The subject, or a default value if not present
  def subject(default = '(No subject)')
    object.subject.presence || default
  end

  ## The contents of a non-multipart message, or a default value if not present
  def body(default = '(No content)')
    (object.multipart? ? multipart_body : unipart_body).presence || default
  end

  def multipart_body
    'MULTIPART'
  end

  def unipart_body
    object.body.decoded.force_encoding(Encoding::UTF_8).strip
  end

  def to_recipients
    addresses_for_header(object[:to])
  end

  def cc_recipients
    addresses_for_header(object[:cc])
  end

  def bcc_recipients
    addresses_for_header(object[:bcc])
  end

  private

  def addresses_for_header(header)
    header.try!(:address_list).try!(:addresses) || []
  end

end
