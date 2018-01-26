module ChgkRating
  module Models
    class Rating < Base
      no_eager_loading!
      no_lazy_support!

      def initialize(release_id_or_hash, params = {})
        @team_id = extract_id_from params[:team]
        super
      end

      private

      def api_path
        "teams/#{@team_id}/rating"
      end
    end
  end
end