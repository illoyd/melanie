class RecentActivityCount < ArangoDB::OGM::Queries::Base

  def initialize(object)
    @object = object
  end

  def to_query
    from_clause = @object.respond_to?(:id) ? @object.id : @object
    "SELECT count(both()) FROM #{ from_clause } WHERE updated_at >=  ORDER BY updated_at DESC"
  end

end
