module ChgkRating
  module Models
    class Tournament < Base
      attr_reader :id, :name, :town, :long_name, :date_start, :date_end, :tour_count,
                  :tour_questions, :tour_ques_per_tour, :questions_total, :type_name, :main_payment_value,
                  :discounted_payment_value, :discounted_payment_reason, :date_requests_allowed_to,
                  :comment, :site_url, :lazy

     # def initialize(id_or_hash, lazy = false)
      def initialize(id_or_hash, params = {})
        super
      end

      def team_players(team_id)
        ChgkRating::Collections::TournamentPlayers.new @id, team_id
      end

      def team_results(team_id)
        ChgkRating::Collections::TournamentTeamResults.new @id, team_id
      end

      def team_list
        ChgkRating::Collections::TournamentTeams.new @id
      end

      def team(team_id)
        ChgkRating::Models::TournamentTeam.new team_id, tournament_id: @id, lazy: true
      end

      private

      def api_path
        'tournaments'
      end

      def extract_from(data)
        @id = data['idtournament']
        @name = data['name']
        @town = data['town']
        @long_name = data['long_name']
        @date_start = Date.parse_safely data['date_start']
        @date_end = Date.parse_safely data['date_end']
        @tour_count = data['tour_count'].to_i
        @tour_questions = data['tour_questions'].to_i
        @tour_ques_per_tour = data['tour_ques_per_tour'].to_i
        @questions_total = data['questions_total'].to_i
        @type_name = data['type_name']
        @main_payment_value = data['main_payment_value'].to_f
        @discounted_payment_value = data['discounted_payment_value'].to_f
        @discounted_payment_reason = data['discounted_payment_reason']
        @date_requests_allowed_to = Date.parse_safely data['date_requests_allowed_to']
        @comment = data['comment']
        @site_url = URI.parse data['site_url']
      end
    end
  end
end