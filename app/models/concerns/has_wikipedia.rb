module HasWikipedia
  extend ActiveSupport::Concern

  included do

    attribute :wikipedia, :string

    def wikipedia_page
      client = MediawikiApi::Client.new "https://en.wikipedia.org/w/api.php"
      #client.get_wikitext(self.wikipedia).body
      client.action(:parse, page: self.wikipedia, token_type: false).data['text']['*'].html_safe
    end

  end

  class_methods do
  end

end