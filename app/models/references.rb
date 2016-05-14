##
# References class!
class References
  include ArangoDB::OGM::Edge

  alias :target :to
  alias :term :to

  alias :origin :from
  alias :note :from

end