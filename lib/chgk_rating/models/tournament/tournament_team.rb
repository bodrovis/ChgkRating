# frozen_string_literal: true

module ChgkRating
  module Models
    class TournamentTeam < Base
      no_eager_loading!

      attr_reader :tournament, :team

      def initialize(team_or_hash, params = {})
        @team = build_model team_or_hash
        @tournament = build_model params[:tournament], ChgkRating::Models::Tournament
        super extract_id_from(team_or_hash), params
      end

      # Returns an array-like TournamentTeamPlayers collection containing roster for the current TournamentTeam
      #
      # @return [ChgkRating::Collection::TournamentTeamPlayers] The collection of results.
      def players
        ChgkRating::Collections::TournamentTeamPlayers.new tournament: @tournament, team: @team
      end

      # Returns an array-like TournamentTeamResults collection containing results for the current TournamentTeam
      #
      # @return [ChgkRating::Collection::TournamentTeamResults] The collection of results.
      def results
        ChgkRating::Collections::TournamentTeamResults.new tournament: @tournament, team: @team
      end
    end
  end
end
