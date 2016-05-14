module Detectors

  class HashtagDetector
    include Twitter::Extractor

    ##
    # Detect all hashtags in the given content.
    # Returns an array of Entity structs.
    def detect(content)
      Array.new.tap do |hashtags|
        extract_hashtags_with_indices(content) do |label, index_start, index_end|
          hashtags << HashtagEntity.new(label, index_start, index_end)
        end
      end
    end

  end

end # Detectors
