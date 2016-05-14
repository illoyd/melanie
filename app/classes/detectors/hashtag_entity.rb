module Detectors

  class HashtagEntity < Entity

    def tag
      "##{ text }"
    end

    def url
      url_helpers.hashtag_url(text, only_path: true)
    end

    def prepared_text
      link_to tag, url
    end

  end

end # Detectors
