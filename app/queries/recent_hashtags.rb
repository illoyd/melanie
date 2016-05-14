module Queries

  class RecentHashtags < Orientdb::ORM::Queries::Base

    def initialize(params = {})
    end

    def to_query
      'SELECT * FROM Hashtag ORDER BY max(Hashtag.mentions.updated_at) LIMIT 100'
    end

    def execute(conn = nil)
      response = execute_query(to_query, conn)
      Result.new( response ).tap do |results|
        Orientdb::ORM::logger.debug { "#{ self.class.name } Results: #{ results }" }
      end
    end

  end

end