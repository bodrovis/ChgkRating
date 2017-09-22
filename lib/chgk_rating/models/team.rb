module ChgkRating
  module Models
    class Team < Base
      attr_reader :id, :name, :town, :comment

      #def initialize(id_or_hash, lazy = false)
      def initialize(id_or_hash, params = {})
        super
      end

      def recaps(params = {})
        ChgkRating::Collections::Recaps.new @id, params
      end

      def recap(season_id)
        ChgkRating::Models::Recap.new season_id, team_id: @id
      end

      def tournaments(season_id, params = {})
        ChgkRating::Collections::Tournaments.new team_or_id: self, season_id: season_id, params: params
      end

      def at_tournament(tournament_id)
        ChgkRating::Models::TournamentTeam.new @id, tournament_id: tournament_id
      end

      def rating(release_id)
        ChgkRating::Models::Rating.new release_id, team_id: @id
      end

      def ratings
        ChgkRating::Collections::Ratings.new @id
      end

      def api_path
        'teams'
      end

      private

      def extract_from(data)
        @id = data['idteam']
        @name = data['name']
        @town = data['town']
        @comment = data['comment']
      end
    end
  end
end