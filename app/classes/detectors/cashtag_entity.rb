module Detectors

  class CashtagEntity < Entity

    def tag
      "$#{ text }"
    end

    def url
      url_helpers.cashtag_url(text, only_path: true)
    end

    def prepared_text
      link_to tag, url
    end

  end

end # Detectors
