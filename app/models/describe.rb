##
# Describes class!
class Describe
  include ArangoDB::OGM::Edge
  include ArangoDB::OGM::Document::Timestamps

  alias :target :to
  alias :note :from

end