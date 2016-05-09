module NasaApod
 
  class SearchResults
    attr_accessor :url, :media_type, :title, :explanation, :hd_url, :date, :copyright
    attr_reader :video_thumbnail_url

    def initialize(attributes={})
      @url = attributes["url"]
      @media_type = attributes["media_type"]
      @explanation = attributes["explanation"] 
      @title = attributes["title"]
      @hd_url = attributes["hdurl"]
      @date = attributes["date"]
      @copyright = attributes["copyright"]
    end

    def video_thumbnail_url
      if @media_type == 'video'
        "http://img.youtube.com/vi/#{youtube_id}/sddefault.jpg"
      end
    end

    private

    def youtube_id
      @url.match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/)[1]
    end
  end
  
end