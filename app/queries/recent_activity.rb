class RecentActivity < ArangoDB::OGM::Queries::Neighbours

  def initialize(*args)
    super ArangoDB::OGM.graph_name, *args
  end

  def to_s
    sql = "FOR v IN GRAPH_NEIGHBORS( '#{ graph }', '#{ start }', #{ parsed_options } ) SORT v.updated_at ASC RETURN v"
    puts sql
    sql
  end

end
