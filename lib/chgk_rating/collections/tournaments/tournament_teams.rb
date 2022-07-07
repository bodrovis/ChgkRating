# frozen_string_literal: true

module ChgkRating
  module Collections
    class TournamentTeams < Base
      attr_reader :tournament

      def initialize(params = {})
        @tournament = build_model params[:tournament], ChgkRating::Models::Tournament

        super
      end

      private

      def process(_results, params = {})
        super { |result| ChgkRating::Models::TournamentTeam.new result, lazy: params[:lazy] }
      end

      def api_path
        "tournaments/#{@tournament.id}/list"
      end
    end
  end
end
