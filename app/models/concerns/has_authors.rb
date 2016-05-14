module HasAuthors
  extend ActiveSupport::Concern

  included do
    # Name, kind, default, validations
    attribute :created_by, :link,   validates: { presence: true }
    attribute :updated_by, :link,   validates: { presence: true }

    # Hook into callbacks
    before_validation :ensure_updated_by

    protected

    def ensure_updated_by
      self.updated_by ||= self.created_by
    end

  end

  class_methods do
  end

end