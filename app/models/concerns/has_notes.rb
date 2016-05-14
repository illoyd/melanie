module HasNotes
  extend ActiveSupport::Concern

  included do

    def notes
      in_objects(:describes)
    end

    end

  class_methods do
  end

end