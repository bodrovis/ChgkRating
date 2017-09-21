module ChgkRating
  module Models
    class Team < Base
      attr_reader :id, :name, :town, :comment

      def initialize(id_or_hash, lazy = false)
        super
      end

      def recaps(params = {})
        ChgkRating::Collections::Recaps.new self.id, params
      end

      def recap(season_id)
        ChgkRating::Models::Recap.new season_id, self.id
      end

      def tournaments(season_id, params = {})
        ChgkRating::Collections::Tournaments.new team_or_id: self, season_id: season_id, params: params
      end

      def rating(season_id = nil)
        get "teams/#{id}/rating/#{season_id}"
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