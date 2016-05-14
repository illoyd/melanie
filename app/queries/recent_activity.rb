class RecentActivity < Orientdb::ORM::Queries::Query

  def initialize(object)
    @object = object
  end

  def to_query
    from_clause = @object.respond_to?(:id) ? @object.id : @object
    "SELECT expand(both()) FROM #{ from_clause } ORDER BY updated_at DESC"
  end

end
