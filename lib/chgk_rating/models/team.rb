module ChgkRating
  module Models
    class Team < Base
      def initialize(id_or_hash, params = {})
        super
      end

      def recaps
        ChgkRating::Collections::Recaps.new team_id: @id
      end

      def recap(season_id)
        ChgkRating::Models::Recap.new season_id, team_id: @id
      end

      def tournaments(season_id: nil, params: {})
        ChgkRating::Collections::Tournaments.new params.merge team: self, season_id: season_id, lazy: true
      end

      def at_tournament(tournament_id)
        ChgkRating::Models::TournamentTeam.new @id, tournament_id: tournament_id, lazy: true
      end

      def rating(release_id)
        ChgkRating::Models::Rating.new release_id, team_id: @id
      end

      def ratings
        ChgkRating::Collections::Ratings.new team_id: @id
      end

      def api_path
        'teams'
      end
    end
  end
end