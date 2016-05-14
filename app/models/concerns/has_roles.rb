module HasRoles
  extend ActiveSupport::Concern

  included do

    def roles
      out_neighbours(:roles)
    end

    end

  class_methods do
  end

end