module HasMentions
  extend ActiveSupport::Concern

  included do

    def mentions
      in_objects(:mentions)
    end

  end

  class_methods do
  end

end