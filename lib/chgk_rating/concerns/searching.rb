module ChgkRating
  module Concerns
    module Searching
      # Some black magic indeed...
      # Creates a Search child class of a given class that changes the URI where the
      # GET request should be sent
      def self.included(klass)
        klass.const_set('Search',
            Class.new(klass) do |*_args|
              def api_path
                super + '/search'
              end
            end
        )

        # The actual method to perform searching
        # Instantiates a Search class with the given search params
        # and send a GET request to the proper URI (defined above)
        klass.define_singleton_method :search do |params|
          klass.const_get('Search').new(params)
        end
      end
    end
  end
end