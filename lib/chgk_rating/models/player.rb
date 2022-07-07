# frozen_string_literal: true

module ChgkRating
  module Models
    class Player < Base
      # Returns rating for the current Player in a given release
      #
      # @return [ChgkRating::Models::PlayerRating] The requested rating.
      # @param release_id [String or Integer] Release to load rating for.
      def rating(release_id)
        ChgkRating::Models::PlayerRating.new release_id, player: self
      end

      # Returns an array-like ratings collection for the current Player.
      #
      # @return [ChgkRating::Collection::PlayerRatings] The collection of ratings.
      def ratings
        ChgkRating::Collections::PlayerRatings.new player: self
      end

      # Returns a collection of Tournaments that the current player participated at based on the given criteria
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when nothing can be found based on the given criteria.
      # @return [ChgkRating::Collection::PlayerTournaments] The collection of tournaments.
      # @param season_id [String or Integer] Season to load tournaments for
      # @option params [String or Integer] :page The requested page. Default is 1
      def tournaments(season_id = nil)
        ChgkRating::Collections::PlayerTournaments.new player: self, season_id: season_id
      end

      private

      def api_path
        'players'
      end
    end
  end
end
