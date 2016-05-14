module FormHelper

  def form_fragment_for(object)
    return form_fragment_for(object.last) if object.is_a?(Array)
    "#{ object.class.name.pluralize.downcase }/form_fragment"
  end

  def form_target_for(object)
    return form_target_for(object.last) if object.is_a?(Array)
    return object.to_url if object.respond_to?(:to_url)

    base = "/#{ object.class.name.tableize }"
    base << "/#{ object._rid.to_param }" if object.persisted?
    base
  end

end
