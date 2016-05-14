require 'orientdb/orm'

##
# Mentions class!
class Mentions < Orientdb::ORM::E

  def target
    @target ||= self.in.fetch
  end

  alias :term :target

  def origin
    @origin ||= self.out.fetch
  end

  alias :note :origin

end