module ChgkRating
  module Models
    class Rating < Base
      no_eager_loading!
      no_lazy_support!
      attr_reader :team_id, :release_id, :rating, :rating_position, :date, :formula

      def initialize(release_id_or_hash, params = {})
        @team_id = params[:team_id]
        super
      end

      private

      def api_path
        "teams/#{@team_id}/rating"
      end

      def extract_from(data)
        @team_id = data['idteam']
        @release_id = data['idrelease']
        @rating = data['rating'].to_i
        @rating_position = data['rating_position'].to_i
        @date = Date.parse_safely data['date']
        @formula = data['formula'].to_sym
      end
    end
  end
end