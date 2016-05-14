require 'orientdb/orm'

##
# Hashtag class!
class Hashtag < Orientdb::ORM::V
  include Orientdb::ORM::HasEdges

  attribute :text, :string, validates: { presence: true }

  def mentions
    self.in_objects(:mentions)
  end

end
