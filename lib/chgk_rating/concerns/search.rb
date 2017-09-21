module ChgkRating
  module Concerns
    module Search
      def self.included(klass)
        search_class = Class.new(klass) do |params_or_ids = {}, lazy = false|
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