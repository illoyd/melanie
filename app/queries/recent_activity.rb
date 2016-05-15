class RecentActivity < BaseQuery

  attr_reader :start, :direction

  def initialize(start: nil, direction: 'any')
    @start = start
    @direction = direction
  end

  def handle
    ArangoDB::OGM::Type.lookup(:document_handle).serialize(@start)
  end

  def direction
    @direction.upcase
  end

  def to_aql
    "FOR v, e IN #{ direction } '#{ handle }' GRAPH '#{ ArangoDB::OGM.graph_name }' SORT e.updated_at DESC RETURN { e: e, v: v }"
  end

  def execute
    ArangoDB::OGM.client('_api/cursor').post('query' => self.to_aql).result.map do |path|
      edge = ArangoDB::OGM.build(path['e'])
      vertex = ArangoDB::OGM.build(path['v'])
      if edge._from == start.document_handle
        edge.from = start
        edge.to = vertex
      else
        edge.from = vertex
        edge.to = start
      end
      edge
    end
  end

end
