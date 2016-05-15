module HasMentions
  extend ActiveSupport::Concern

  included do

    def mentions
      neighbours(Mention)
    end

  end

  class_methods do
  end

end