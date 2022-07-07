# frozen_string_literal: true

module ChgkRating
  module Models
    class Recap < Base
      no_eager_loading!
      no_lazy_support!

      def initialize(season_id_or_hash, params = {})
        @team_id = extract_id_from params[:team]
        super
      end

      private

      def api_path
        "teams/#{@team_id}/recaps"
      end
    end
  end
end
