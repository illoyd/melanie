require 'orientdb/orm'

##
# Sends edge. For showing who has sent an Email or other note.
class Sends < Orientdb::ORM::E

  def person
    out_object
  end

  def email
    in_object
  end

end