module NasaApod
 
  class SearchResults
    attr_accessor :concepts, :url, :media_type, :title, :explanation, :hd_url, :date

    def initialize(attributes={})
      @concepts = attributes["concepts"]
      @url = attributes["url"]
      @media_type = attributes["media_type"]
      @explanation = attributes["explanation"] 
      @title = attributes["title"]
      @hd_url = attributes["hdurl"]
      @date = attributes["date"]
    end
  end
  
end