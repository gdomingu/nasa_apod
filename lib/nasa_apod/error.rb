module NasaApod
 
  class Error
    attr_reader :code, :code_definition, :message

    def initialize(response)
      @code = response.code
      @code_definition = response.message
      @message = response["error"]["message"] if response["error"]
    end
  end
  
end