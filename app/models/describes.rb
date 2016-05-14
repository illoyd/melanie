require 'orientdb/orm'

##
# Describes class!
class Describes < Orientdb::ORM::E
  
  def target
    @target ||= self.in.fetch
  end
  
  def note
    @note ||= self.out.fetch
  end
  
end