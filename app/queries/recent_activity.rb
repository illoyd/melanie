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
    "FOR v, e IN #{ direction } @document GRAPH @graph_name SORT e.updated_at DESC RETURN { e: e, v: v }"
  end

  def to_bindvars
    { 'document' => handle, 'graph_name' => ArangoDB::OGM.graph_name }
  end

  def execute
    result = ArangoDB::OGM::CollectionResult.new(ArangoDB::OGM.client('_api/cursor').post('query' => self.to_aql, 'bindVars' => self.to_bindvars).body)
    result.map do |path|
      if path['e']._from == start.document_handle
        path['e'].from = start
        path['e'].to = path['v']
      else
        path['e'].from = path['v']
        path['e'].to = start
      end
      path['e']
    end
  end

end
