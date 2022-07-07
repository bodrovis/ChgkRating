# frozen_string_literal: true

module ChgkRating
  module Collections
    class TeamRatings < Base
      attr_reader :team

      def initialize(params = {})
        @team = build_model params[:team]
        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::TeamRating.new result }
      end

      def api_path
        "teams/#{@team.id}/rating"
      end
    end
  end
end
