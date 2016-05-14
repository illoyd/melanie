module HasMentions
  extend ActiveSupport::Concern

  included do

    def mentions
      in_neighbours(:mentions)
    end

  end

  class_methods do
  end

end