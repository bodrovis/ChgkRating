module ChgkRating
  module Collections
    class Players < Base
      attr_reader :lazy

      def initialize(params_or_ids = {}, lazy = false)
        collection = params_or_ids.is_a?(Array) ? params_or_ids : get('players', params_or_ids)['items']

        @items = collection.map {|raw_player| ChgkRating::Models::Player.new(raw_player, lazy) }
        @lazy = lazy
      end
    end
  end
end