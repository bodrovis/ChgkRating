module ChgkRating
  module Collections
    class Tournaments < Base
      include ChgkRating::Concerns::Pagination

      attr_reader :team, :season_id

      def initialize(params = {})
        @team = if params[:team].instance_of?(ChgkRating::Models::Team)
                  params[:team]
                else
                  ChgkRating::Models::Team.new(params[:team], lazy: true) if params[:team]
                end
        @season_id = params[:season_id]

        super
      end

      private

      def process(result, params = {})
        ChgkRating::Models::Tournament.new result, lazy: params[:lazy]
      end

      def api_path
        path = 'tournaments'
        return path unless @team
        path = "#{@team.api_path}/#{@team.id}/#{path}"
        return path unless @season_id
        path + "/#{@season_id}"
      end
    end
  end
end