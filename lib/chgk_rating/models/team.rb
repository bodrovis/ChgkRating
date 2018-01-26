module ChgkRating
  module Models
    class Team < Base
      def recap(season_id)
        ChgkRating::Models::Recap.new season_id, team: self
      end

      def at_tournament(tournament_or_id)
        ChgkRating::Models::TournamentTeam.new self, tournament: tournament_or_id, lazy: true
      end

      def rating(release_id)
        ChgkRating::Models::Rating.new release_id, team: self
      end

      def ratings
        ChgkRating::Collections::Ratings.new team: self
      end

      def recaps
        ChgkRating::Collections::Recaps.new team: self
      end

      def tournaments(season_id: nil, params: {})
        ChgkRating::Collections::Tournaments.new params.merge team: self, season_id: season_id, lazy: true
      end

      private

      def api_path
        'teams'
      end
    end
  end
end