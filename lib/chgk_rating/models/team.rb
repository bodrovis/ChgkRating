module ChgkRating
  module Models
    class Team < Base
      attr_reader :id, :name, :town, :comment

      def initialize(id_or_hash, lazy = false)
        super
      end

      def recaps
        ChgkRating::Collections::Recaps.new self.id
      end

      def recap(season_id)
        ChgkRating::Models::Recap.new season_id, self.id
      end

      private

      def api_path
        'teams'
      end

      def extract_from(data)
        @id = data['idteam']
        @name = data['name']
        @town = data['town']
        @comment = data['comment']
      end
    end
  end
end