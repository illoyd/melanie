##
# Sends edge. For showing who has sent an Email or other note.
class Send
  include ArangoDB::OGM::Edge
  include ArangoDB::OGM::Model::Timestamps

  alias :person :from

  alias :email :to

end