module Detectors

  class CashtagDetector
    include Twitter::Extractor

    ##
    # Detect all cashtags in the given content.
    # Returns an array of Entity structs.
    def detect(content)
      Array.new.tap do |cashtags|
        extract_cashtags_with_indices(content) do |label, index_start, index_end|
          cashtags << CashtagEntity.new(label, index_start, index_end)
        end
      end
    end

  end

end # Detectors
