module Detectors

  class Entity
    include Comparable

    delegate :url_helpers, to: 'Rails.application.routes'
    delegate :link_to,     to: 'ActionController::Base.helpers'

    attr_reader :text, :indices

    def initialize(text, position_start, position_end)
      @text = text
      @indices = [ position_start, position_end ]
    end

    def prepared_text
      text
    end

    def position_start
      @indices[0]
    end

    def position_end
      @indices[1]
    end

    def <=>(other)
      indices <=> other.indices
    end

  end

end # Detectors
