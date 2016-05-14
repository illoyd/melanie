require 'orientdb/orm'

##
# Receives edge. For linking a Person to an Email or other note.
class Receives < Orientdb::ORM::E

  def person
    out_object
  end

  def email
    in_object
  end

end