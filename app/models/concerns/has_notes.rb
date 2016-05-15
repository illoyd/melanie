module HasNotes
  extend ActiveSupport::Concern

  included do

    def notes
      in_neighbours(Describe)
    end

  end

  class_methods do
  end

end