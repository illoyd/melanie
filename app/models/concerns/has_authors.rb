module HasAuthors
  extend ActiveSupport::Concern

  included do
    # Name, kind, default, validations
    attribute :created_by, :document_handle,   validates: { presence: true }
    attribute :updated_by, :document_handle,   validates: { presence: true }

    # Hook into callbacks
    before_validation :ensure_updated_by

    def created_by
      @cached_created_by ||= self.attribute('created_by').fetch
    end

    def updated_by
      @cached_updated_by ||= self.attribute('updated_by').fetch
    end

    protected

    def ensure_updated_by
      self.updated_by ||= self.created_by
    end

  end

  class_methods do
  end

end