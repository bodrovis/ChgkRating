# frozen_string_literal: true

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
      body = MultiJson.load response.body
      raise MultiJson::ParseError if body.respond_to?(:has_key?) && body.key?('error')

      body
    rescue MultiJson::ParseError
      respond_with_error response.status, response.body
    end

    def respond_with_error(code, body)
      raise ChgkRating::Error::ERRORS[code].from_response(body)
    end
  end
end
