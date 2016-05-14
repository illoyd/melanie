##
# Sends edge. For showing who has sent an Email or other note.
class Sends
  include ArangoDB::OGM::Edge

  alias :person :from

  alias :email :to

end