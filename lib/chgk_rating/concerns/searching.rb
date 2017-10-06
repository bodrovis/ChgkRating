module ChgkRating
  module Concerns
    module Searching
      # some black magic
      def self.included(klass)
        search_class = Class.new(klass) do |*_args|
          def api_path
            super + '/search'
          end
        end
        klass.define_singleton_method :search do |params|
          search_class.new(params)
        end
      end
    end
  end
end