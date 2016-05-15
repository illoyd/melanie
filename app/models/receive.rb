##
# Receives edge. For linking a Person to an Email or other note.
class Receive
  include ArangoDB::OGM::Edge
  include ArangoDB::OGM::Document::Timestamps

  alias :person :from

  alias :email :to

end