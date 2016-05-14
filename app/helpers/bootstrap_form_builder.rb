class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  # Here we have access to a number of useful variables
  #
  # ** template  (use this to invoke any helpers)(ex. template.hidden_field_tag(...))
  # ** object    (the record for this form) (ex. object.valid?)
  # ** object_name (object's underscored type) (ex. object_name => 'admin_user')
  #
  # We also have access to self.field_types => [:text_field, :text_area, ...]
  # In addition, we have access to all the existing field tag
  # helpers (text_field, hidden_field, file_field, ...)

#   def label(field, options={}, &block)
#     options[:id] ||= nil
#     options[:caption] ||= I18n.t("#{model_name}.attributes.#{field}", :count => 1, :default => field.to_s.humanize, :scope => :models)
#     @template.label_tag(field_id(field), default_options(field, options), &block)
#   end

  (self.field_helpers - [ :hidden_field, :radio_button ]).each do |field_type|
    class_eval <<-EOF
    def #{field_type}_block(field, options={}, label_options={})
      temporarily_disable_field_error_proc do
        label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]

        # Inject label bootstrap class
        label_options.merge!(class: 'form-control-label')

        # Inject control bootstrap class
        options.merge!(class: 'form-control')
        options[:class] << ' form-control-error' if object.errors.include?(field)

        # Inject wrapper bootstrap class
        div_options = { class: 'form-group' }
        div_options[:class] << ' has-error' if object.errors.include?(field)

        # Compile tag
        field_html = label(field, label_options)
        field_html << #{field_type}(field, options)
        @template.content_tag(:div, field_html, div_options)
      end
    end
    EOF
  end

  def submit(options = {})
    caption = object.persisted? ? 'Save Changes' : 'Save New'
    options.reverse_merge!(class: 'btn btn-primary')
    super(caption, options)
  end

  def cancel(options = {})
    caption = object.persisted? ? 'Discard Changes' : 'Discard New'
    options.reverse_merge!(class: 'btn btn-default', "data-dismiss" => "modal")
    @template.link_to(caption, object, options)
  end

  def cancel_modal(options = {})
    caption = object.persisted? ? 'Discard Changes' : 'Discard New'
    options.reverse_merge!(class: 'btn btn-default btn-simple', "data-dismiss" => "modal")
    @template.button_tag(caption, options)
  end

  def submit_block(caption, options={})
    submit_html = self.submit(caption, options)
    @template.content_tag(:div, submit_html, class: 'form-group')
  end

  def image_submit_block(source, options={})
    submit_html = self.image_submit(source, options)
    @template.content_tag(:div, submit_html, class: 'form-group')
  end

  def temporarily_disable_field_error_proc
    original_proc = ActionView::Base.field_error_proc
    ActionView::Base.field_error_proc = proc { |input, instance| input }
    yield
  ensure
    ActionView::Base.field_error_proc = original_proc
  end
end