class BaseQuery

  def inspect
    "#<#{ self.class } #{ self.to_aql }>"
  end

  def to_aql
    raise NotImplementedError
  end

  alias :to_s :to_aql

  def execute
    raise NotImplementedError
  end

  protected

  def collection_names_for(*names)
    names.flatten.map { |name| name.try(:collection_name) || name }
  end

end
