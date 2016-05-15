module HasHashtags
  extend ActiveSupport::Concern

  included do

    def hashtags
      in_neighbours(Mention)
    end

  end

  class_methods do
  end

end