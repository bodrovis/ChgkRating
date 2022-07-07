# frozen_string_literal: true

module ChgkRating
  module Collections
    class PlayerRatings < Base
      attr_reader :player

      def initialize(params = {})
        @player = build_model params[:player], ChgkRating::Models::Player
        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::PlayerRating.new result }
      end

      def api_path
        "players/#{@player.id}/rating"
      end
    end
  end
end
