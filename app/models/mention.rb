##
# Mentions class!
class Mention
  include ArangoDB::OGM::Edge
  include ArangoDB::OGM::Model::Timestamps

  alias :target :to
  alias :term :to

  alias :origin :from
  alias :note :from

end