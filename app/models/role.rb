require 'orientdb/orm'

##
# Describes class!
class Role < Orientdb::ORM::E
  attribute :in,    :link, default: nil, validates: { presence: true }
  attribute :out,   :link, default: nil, validates: { presence: true }
  attribute :title, :string

  def organization
    @organization ||= self[:in].try(:fetch)
  end

  def person
    @person ||= self[:out].try(:fetch)
  end

end