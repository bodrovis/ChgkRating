module ChgkRating
  module Collections
    class TournamentPlayers < Base
      def initialize(tournament_id, team_id)
        path = "tournaments/#{tournament_id}/recaps/#{team_id}"
        @items = get(path).map {|raw_player| ChgkRating::Models::TournamentPlayer.new(raw_player) }
      end
    end
  end
end