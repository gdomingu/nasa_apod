module NasaApod
  DEFAULT_URL = 'https://api.nasa.gov/planetary/apod'

  class Client
    attr_reader :date
    attr_accessor :hd, :api_key

    def date=(date)
      @date = parse_date(date)
    end

    def initialize(options = {})
      self.api_key = options[:api_key] || 'DEMO_KEY'
      self.date = options[:date]
      self.hd = options[:hd]
    end

    # Returns APOD info for specified day.
    #
    # @see https://api.nasa.gov/api.html#apod
    # @rate_limited Yes https://api.nasa.gov/api.html#authentication
    # @image_permissions http://apod.nasa.gov/apod/lib/about_apod.html#srapply
    # @authentication optional NASA api key https://api.nasa.gov/index.html#apply-for-an-api-key
    # @option options [String] :api_key Optional. Uses DEMO_KEY as default.
    # @option options [String] :date Optional. Returns the APOD results for
    # the given date. Date should be formatted as YYYY-MM-DD. Defaults as today.
    # @return [NasaApod::SearchResults] Return APOD post for a specified date.
    def search(options = {})
      self.date = options[:date] || date
      self.hd = options[:hd] || hd
      response = HTTParty.get(DEFAULT_URL, query: attributes)
      handle_response(response)
    end

    def random_post(options = {})
      date = rand(Date.parse('1995-06-16')..Date.today)
      options[:date] = date
      search(options)
    end

    alias wormhole random_post

    private

    def attributes
      instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end

    def handle_response(response)
      if response['error'].nil?
        NasaApod::SearchResults.new(response)
      else
        NasaApod::Error.new(response)
      end
    end

    def parse_date(date)
      case date
      when Time
        date.strftime('%Y-%m-%d')
      when Date
        date.to_s
      when String
        date
      else
        Date.today.to_s
      end
    end
  end
  
end
