##
# Describes class!
class Describe
  include ArangoDB::OGM::Edge
  include ArangoDB::OGM::Model::Timestamps

  alias :target :to
  alias :note :from

end