module ChgkRating
  class Error < StandardError
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    EagerLoadingNotSupported = Class.new(ClientError) do
      def to_s
        'Eager loading is not supported for this resource.'
      end
    end

    BadRequest = Class.new(ServerError)
    NotFound = Class.new(ServerError)
    NotImplemented = Class.new(ServerError)

    ERRORS = {
        400 => ChgkRating::Error::BadRequest,
        404 => ChgkRating::Error::NotFound,
        501 => ChgkRating::Error::NotImplemented
    }

    class << self
      # Create a new error from an HTTP response
      def from_response(body)
        new(body.to_s)
      end
    end

    # Initializes a new Error object
    def initialize(message = '')
      super(message)
    end
  end
end