module ChgkRating
  module Request
    include ChgkRating::Connection

    def get(path, params = {})
      respond perform_get(path, params)
    end

    private

    def perform_get(path, params)
      connection.get do |req|
        req.url path
        req.params = params
      end
    end

    def respond(response)
      begin
        MultiJson.load response.body
      rescue MultiJson::ParseError
        return_error response.status, response.body
      end
    end

    def return_error(code, body)
      fail error(code, body)
    end

    def error(code, body)
      # unless [200, 201].include?(code)
      #   klass = OkLinker::Error::ERRORS[code]
      #   klass.from_response(body)
      # end
    end
  end
end