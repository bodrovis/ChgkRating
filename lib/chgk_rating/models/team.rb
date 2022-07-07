# frozen_string_literal: true

module ChgkRating
  module Models
    class Team < Base
      # Returns a single Recap for the current Team at a given season
      #
      # @raise [ChgkRating::Error::BadRequest] Error raised when the requested season is invalid
      # @return [ChgkRating::Models::Recap] The requested Recap.
      # @param season_id [String or Integer] Season to load recap for.
      def recap(season_id)
        ChgkRating::Models::Recap.new season_id, team: self
      end

      # Returns TournamentTeam for the current Team at a given tournament
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when the requested Tournament cannot be found.
      # @return [ChgkRating::Models::TournamentTeam] The requested TournamentTeam.
      # @param tournament_or_id [String, Integer or Tournament] Tournament to load the team for
      def at_tournament(tournament_or_id)
        ChgkRating::Models::TournamentTeam.new self, tournament: tournament_or_id, lazy: true
      end

      # Returns rating for the current Team in a given release
      #
      # @return [ChgkRating::Models::TeamRating] The requested rating.
      # @param release_id [String or Integer] Release to load rating for.
      def rating(release_id)
        ChgkRating::Models::TeamRating.new release_id, team: self
      end

      # Returns an array-like ratings collection for the current Team.
      #
      # @return [ChgkRating::Collection::TeamRatings] The collection of ratings.
      def ratings
        ChgkRating::Collections::TeamRatings.new team: self
      end

      # Returns an hash-like Recaps collection for the current team, grouped by seasons. Seasons act
      # as keys, whereas Recap models - as values.
      #
      # @return [ChgkRating::Collection::Recaps] The collection of recaps.
      def recaps
        ChgkRating::Collections::Recaps.new team: self
      end

      # Returns a collection of Tournaments that the current team participated at based on the given criteria
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when nothing can be found based on the given criteria.
      # @return [ChgkRating::Collection::Tournaments] The collection of tournaments.
      # @param season_id [String or Integer] Season to load tournaments for
      # @option params [String or Integer] :page The requested page. Default is 1
      def tournaments(season_id: nil, params: {})
        ChgkRating::Collections::Tournaments.new params.merge team: self, season_id: season_id, lazy: true
      end

      private

      def api_path
        'teams'
      end
    end
  end
end
