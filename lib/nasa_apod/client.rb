module NasaApod
 
  DEFAULT_URL = 'https://api.nasa.gov/planetary/apod'
  
  class Client
    attr_reader :api_key, :date, :concept_tags, :hd

    def date=(date)
      @date = parse_date(date)
    end

    def concept_tags=(concept_tags)
      if concept_tags.nil? || concept_tags.blank?
        @concept_tags = false
      else
        @concept_tags = concept_tags
      end
    end

    def hd=(hd)
      if hd.nil? || hd.blank?
        @hd = false
      else
        @hd = hd
      end
    end
    
    def initialize(options={})
      @api_key = options[:api_key] || "DEMO_KEY"
      self.date = options[:date]
      self.concept_tags = options[:concept_tags]
      self.hd = options[:hd]
    end

    # Returns APOD info for specified day.
    #
    # @see https://api.nasa.gov/api.html#apod
    # @rate_limited Yes https://api.nasa.gov/api.html#authentication
    # @image_permissions http://apod.nasa.gov/apod/lib/about_apod.html#srapply
    # @authentication optional NASA api key https://api.nasa.gov/index.html#apply-for-an-api-key
    # @option options [String] :api_key Optional. Uses DEMO_KEY as default.
    # @option options [String] :date Optional. Returns the APOD results for the given date. Date should be formatted as YYYY-MM-DD. Defaults as today.
    # @option options [Boolean] :concept_tags Optional. Returns an array of concept tags if available. Defaults to False.
    # @return [NasaApod::SearchResults] Return APOD post for a specified date.
    def search(options={})
      self.date = options[:date] || date
      @concept_tags = options[:concept_tags] || concept_tags
      @hd = options[:hd] || hd
      response = HTTParty.get(DEFAULT_URL, { query: attributes })
      handle_response(response)
    end

    def random_post(options={})
      date = rand(Date.parse("1995-06-16")..Date.today)
      search(date: date)
    end

    alias_method :wormhole, :random_post

    def attributes
      instance_variables.each_with_object(Hash.new) do  |var,hash| 
        hash[var.to_s.delete("@")] = instance_variable_get(var)
      end
    end

    private

    def handle_response(response)
      if response["error"].nil?
        NasaApod::SearchResults.new(response)
      else
        NasaApod::Error.new(response)
      end
    end

    def parse_date(date)
      if date.is_a?(Time)
        date.strftime("%Y-%m-%d")
      elsif date.is_a?(Date)
        date.to_s
      elsif date.is_a?(String)
        date
      else
        Date.today.to_s
      end
    end
  end
  
end
