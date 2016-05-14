##
# Receives edge. For linking a Person to an Email or other note.
class Receives
  include ArangoDB::OGM::Edge

  alias :person :from

  alias :email :to

end