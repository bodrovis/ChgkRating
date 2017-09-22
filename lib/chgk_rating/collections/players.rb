module ChgkRating
  module Collections
    class Players < Base
      include ChgkRating::Concerns::Search
      attr_reader :lazy

      def initialize(params_or_ids = {}, lazy = false)
        collection = params_or_ids.is_a?(Array) ? params_or_ids : get(api_path, params_or_ids)['items']

        @items = collection.map do |raw_player|
          ChgkRating::Models::Player.new(raw_player, lazy: lazy)
        end
        @lazy = lazy
      end

      def api_path
        'players'
      end
    end
  end
end