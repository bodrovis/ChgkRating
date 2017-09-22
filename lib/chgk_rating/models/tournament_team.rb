module ChgkRating
  module Models
    class TournamentTeam < Base
      no_eager_loading!

      attr_reader :id, :current_name, :base_name, :position, :questions_total,
                  :mask, :bonus_a, :bonus_b, :tech_rating, :predicted_position,
                  :real_bonus_b, :d_bonus_b, :included_in_rating

     # def initialize(team_id_or_hash, tournament_id = nil)
      def initialize(team_id_or_hash, params = {})
        @tournament_id = params[:tournament_id]
        super# team_id_or_hash, !team_id_or_hash.is_a?(Hash)
      end

      def players
        ChgkRating::Collections::TournamentPlayers.new tournament_id: @tournament_id, team_id: @id
      end

      def results
        ChgkRating::Collections::TournamentTeamResults.new tournament_id: @tournament_id, team_id: @id
      end

      private

      def extract_from(data)
        @id = data['idteam']
        @current_name = data['current_name']
        @base_name = data['base_name']
        @position = data['position'].to_f
        @questions_total = data['questions_total'].to_i
        @mask = data['mask'].split('').map {|result| to_boolean result}
        @bonus_a = data['bonus_a'].to_i
        @bonus_b = data['bonus_b'].to_i
        @tech_rating = data['tech_rating'].to_i
        @predicted_position = data['predicted_position'].to_i
        @real_bonus_b = data['real_bonus_b'].to_i
        @d_bonus_b = data['d_bonus_b'].to_i
        @included_in_rating = to_boolean data['included_in_rating']
      end
    end
  end
end