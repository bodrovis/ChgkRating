module ChgkRating
  module Concerns
    module Searching
      # some black magic
      def self.included(klass)
        klass.const_set(
            'Search',
            Class.new(klass) do |*_args|
              def api_path
                super + '/search'
              end
            end
        )

        klass.define_singleton_method :search do |params|
          klass.const_get('Search').new(params)
        end
      end
    end
  end
end