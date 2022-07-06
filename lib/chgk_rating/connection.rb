require 'faraday/follow_redirects'

module ChgkRating
  module Connection
    BASE_URL = 'http://rating.chgk.info/api'.freeze

    def connection
      options = {
          headers: {
              accept: 'application/json',
              user_agent: "chgk_rating ruby gem/#{ChgkRating::VERSION}"
          },
          url: BASE_URL + '/'
      }

      Faraday.new options do |faraday|
        faraday.use Faraday::FollowRedirects::Middleware
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
