class PersonDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def important_dates
    object.attributes.select do |k,v|
      v.acts_like?(:date) && !['created_at', 'updated_at'].include?(k)
    end
  end

  def friendly_name
    object.full_name
  end

end
