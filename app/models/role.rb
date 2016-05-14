##
# Describes class!
class Role
  include ArangoDB::OGM::Edge

  attribute :title, :string

  alias :organization :to

  alias :person :from

end