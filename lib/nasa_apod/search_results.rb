module NasaApod
 
  class SearchResults
    attr_accessor :url, :media_type, :title, :explanation, :hd_url, :date, :copyright

    def initialize(attributes={})
      @url = attributes["url"]
      @media_type = attributes["media_type"]
      @explanation = attributes["explanation"] 
      @title = attributes["title"]
      @hd_url = attributes["hdurl"]
      @date = attributes["date"]
      @copyright = attributes["copyright"]
    end
  end
  
end