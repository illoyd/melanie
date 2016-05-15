module HasRoles
  extend ActiveSupport::Concern

  included do

    def roles
      edges(Role)
    end

  end

  class_methods do
  end

end