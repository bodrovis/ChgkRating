module ChgkRating
  module Models
    class Player < Base
      # Returns Rating for the current Player in a given release
      #
      # @return [ChgkRating::Models::Rating] The requested Rating.
      # @param release_id [String or Integer] Release to load rating for.
      def rating(release_id)
        ChgkRating::Models::Rating.new release_id, player: self
      end

      # Returns an array-like Ratings collection for the current Player.
      #
      # @return [ChgkRating::Collection::Ratings] The collection of ratings.
      def ratings
        ChgkRating::Collections::Ratings.new player: self
      end

      # Returns a collection of Tournaments that the current player participated at based on the given criteria
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when nothing can be found based on the given criteria.
      # @return [ChgkRating::Collection::Tournaments] The collection of tournaments.
      # @param season_id [String or Integer] Season to load tournaments for
      # @option params [String or Integer] :page The requested page. Default is 1
      def tournaments(season_id: nil, params: {})
        ChgkRating::Collections::Tournaments.new params.merge player: self, season_id: season_id, lazy: true
      end

      private

      def api_path
        'players'
      end
    end
  end
end