module ChgkRating
  module Collections
    class TournamentTeamResults < Base
      def initialize(tournament_id, team_id)
        path = "tournaments/#{tournament_id}/results/#{team_id}"
        @items = get(path).map {|raw_result| ChgkRating::Models::TournamentTeamResult.new(raw_result) }
      end
    end
  end
end