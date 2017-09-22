module ChgkRating
  module Collections
    class TournamentTeams < Base
      def initialize(tournament_id)
        path = "tournaments/#{tournament_id}/list"
        @items = get(path).map {|raw_list| ChgkRating::Models::TournamentTeam.new(raw_list) }
      end
    end
  end
end