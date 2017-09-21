module ChgkRating
  module Models
    class Tournament < Base
      attr_reader :id, :name, :town, :long_name, :date_start, :date_end, :tour_count,
                  :tour_questions, :tour_ques_per_tour, :questions_total, :type_name, :main_payment_value,
                  :discounted_payment_value, :discounted_payment_reason, :date_requests_allowed_to,
                  :comment, :site_url, :lazy

      def initialize(id_or_hash, lazy = false)
        super
      end

      def team_list
        get("tournaments/#{id}/list")
      end

      def recap(team_id)
        get("tournaments/#{id}/recaps/#{team_id}")
      end

      def result(team_id)
        get("tournaments/#{id}/results/#{(team_id)}")
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
        @date_start = data['date_start']
        @date_end = data['date_end']
        @tour_count = data['tour_count']
        @tour_questions = data['tour_questions']
        @tour_ques_per_tour = data['tour_ques_per_tour']
        @questions_total = data['questions_total']
        @type_name = data['type_name']
        @main_payment_value = data['main_payment_value']
        @discounted_payment_value = data['discounted_payment_value']
        @discounted_payment_reason = data['discounted_payment_reason']
        @date_requests_allowed_to = data['date_requests_allowed_to']
        @comment = data['comment']
        @site_url = data['site_url']
      end
    end
  end
end