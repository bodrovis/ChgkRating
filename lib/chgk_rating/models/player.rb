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

      private

      def api_path
        'players'
      end
    end
  end
end