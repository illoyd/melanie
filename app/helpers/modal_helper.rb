module ModalHelper

  def modal_title_for(object)
    return modal_title_for(object.last) if object.is_a?(Array)
    object.persisted? ? "Edit #{ object.class.name.humanize }" : "New #{ object.class.name.humanize }"
  end

  def modal_id_for(object)
    return modal_id_for(object.last) if object.is_a?(Array)
    id = object.persisted? ? "#{ object.document_handle.collection }_#{ object.document_handle.position }" : 'new'
    "#{ object.class.name.underscore }_#{ id }"
  end

  def modal_data_target_for(object)
    "##{ modal_id_for(object) }"
  end

  def modal_button(caption, object, options = {})
    options.reverse_merge!(class: 'btn btn-secondary', type: 'button', data: { target: modal_data_target_for(object), toggle: 'modal' })
    content_tag(:button, caption, options)
  end

end
