##
# Describes class!
class Describes
  include ArangoDB::OGM::Edge

  alias :target :to
  alias :note :from

end