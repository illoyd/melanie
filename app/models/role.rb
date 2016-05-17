##
# Describes class!
class Role
  include ArangoDB::OGM::Edge
  include ArangoDB::OGM::Model::Timestamps

  include HasAuthors

  attribute :title, :string

  attribute :effective_from, :date
  attribute :effective_to, :date

  alias :organization :to
  alias :person :from

  def active?
    effective_to.blank? || effective_to >= Date.today
  end

end