module ChgkRating
  module AttributeMappings
    extend ChgkRating::Utils::BooleanParser

    private

    class << self
      def generate_mappings_for(data)
        data.each do |const_name, raw_schema|
          const_set const_name, generate_mapping_for(raw_schema)
        end
      end

      def to_model(namespace)
        ->(d) {
          Module.const_get("ChgkRating::Models::#{namespace}").new d, lazy: true
        }
      end

      def to_collection(namespace)
        ->(d) {
          Module.const_get("ChgkRating::Collections::#{namespace}").new collection: d, lazy: true
        }
      end

      def to_id
        ->(d) { d.id }
      end

      def to_ids
        ->(d) { d.map {|obj| obj.id } }
      end

      def string_integer
        {
            transform_up: ->(d) { d.to_i },
            transform_down: ->(d) { d.to_s }
        }
      end

      def string_float
        {
            transform_up: ->(d) { d.to_f },
            transform_down: ->(d) { d.to_s }
        }
      end

      def string_uri
        {
            transform_up: ->(d) { URI.parse_safely d },
            transform_down: ->(d) { d.to_s }
        }
      end

      def string_boolean
        {
            transform_up: ->(d) { to_boolean(d) },
            transform_down: ->(d) { to_binary_boolean d }
        }
      end

      def string_date
        {
            transform_up: ->(d) { Date.parse_safely d },
            transform_down: ->(d) { d.to_s_chgk }
        }
      end

      def string_datetime
        {
            transform_up: ->(d) { DateTime.parse_safely d },
            transform_down: ->(d) { d.to_s_chgk }
        }
      end

      def string_sym
        {
            transform_up: ->(d) { d.to_sym },
            transform_down: ->(d) { d.to_s }
        }
      end

      def string_boolean_split_array
        {
            transform_up: ->(d) do
              d.split('').map {|result| to_boolean(result) }
            end,
            transform_down: ->(d) do
              d.map {|result| to_binary_boolean(result) }
            end
        }
      end

      def string_boolean_array
        {
            transform_up: ->(d) do
              d.map {|result| to_boolean(result) }
            end,
            transform_down: ->(d) do
              d.map {|result| to_binary_boolean(result) }
            end
        }
      end

      def team_model
        {
            transform_up: to_model('Team'),
            transform_down: to_id
        }
      end

      def player_model
        {
            transform_up: to_model('Player'),
            transform_down: to_id
        }
      end

      def players_collection
        {
            transform_up: to_collection('Players'),
            transform_down: to_ids,
        }
      end

      def to_name(raw_name)
        {raw_name: raw_name.to_s}
      end

      def parse_raw_scheme(raw_scheme)
        # raw_scheme - hash or symbol
        mapping = {}
        if raw_scheme.is_a? Hash
          # key - symbol
          # value - string or array
          key, value = raw_scheme.first
          if value.is_a?(String)
            mapping[key] = to_name(value)
          elsif value.is_a?(Array)
            # value[0] - string, raw key name
            # value[1] - symbol, model name that turns to method name (eg, team_model)
            mapping[key] = to_name(value[0]).merge send(value[1])
          end
        else
          # raw_scheme is a string
          #key = raw_scheme
          mapping[raw_scheme] = to_name(raw_scheme)
        end
        mapping
      end

      def generate_mapping_for(schemes)
        return unless schemes.is_a?(Array) && schemes.any?
        
        # scheme - array of hashes or symbols
        schemes.inject({}) do |memo, raw_scheme|
          # raw_scheme - hash or symbol
          memo.merge parse_raw_scheme(raw_scheme)
        end.freeze
      end
    end

    self.generate_mappings_for({
                                   PLAYER: [
                                       {
                                           id: 'idplayer'
                                       },
                                       :name,
                                       :surname,
                                       :patronymic,
                                       :comment,
                                       :db_chgk_info_tag
                                   ],
                                   RATING: [
                                       {
                                           team: ['idteam', :team_model]
                                       },
                                       {
                                           release_id: 'idrelease'
                                       },
                                       {
                                           rating: ['rating', :string_integer]
                                       },
                                       {
                                           rating_position: ['rating_position', :string_integer]
                                       },
                                       {
                                           date: ['date', :string_date]
                                       },
                                       {
                                           formula: ['formula', :string_sym]
                                       }
                                   ],
                                   RECAP: [
                                       {
                                           season_id: 'idseason'
                                       },
                                       {
                                           team: ['idteam', :team_model]
                                       },
                                       {
                                           captain: ['captain', :player_model]
                                       },
                                       {
                                           players: ['players', :players_collection]
                                       }
                                   ],
                                   TOURNAMENT: [
                                       {
                                           id: 'idtournament'
                                       },
                                       :name,
                                       :town,
                                       :long_name,
                                       {
                                           date_start: ['date_start', :string_datetime]
                                       },
                                       {
                                           date_end: ['date_end', :string_datetime]
                                       },
                                       {
                                           tour_count: ['tour_count', :string_integer]
                                       },
                                       {
                                           tour_questions: ['tour_questions', :string_integer]
                                       },
                                       {
                                           tour_ques_per_tour: ['tour_ques_per_tour', :string_integer]
                                       },
                                       {
                                           questions_total: ['questions_total', :string_integer]
                                       },
                                       :type_name,
                                       {
                                           main_payment_value: ['main_payment_value', :string_float]
                                       },
                                       {
                                           discounted_payment_value: ['discounted_payment_value', :string_float]
                                       },
                                       :discounted_payment_reason,
                                       {
                                           date_requests_allowed_to: ['date_requests_allowed_to', :string_datetime]
                                       },
                                       :comment,
                                       {
                                           site_url: ['site_url', :string_uri]
                                       },
                                   ],
                                   TOURNAMENT_PLAYER: [
                                       {
                                           id: 'idplayer'
                                       },
                                       {
                                           is_captain: ['is_captain', :string_boolean]
                                       },
                                       {
                                           is_base: ['is_base', :string_boolean]
                                       },
                                       {
                                           is_foreign: ['is_foreign', :string_boolean]
                                       }
                                   ],
                                   TOURNAMENT_TEAM: [
                                       {
                                           id: 'idteam'
                                       },
                                       :current_name,
                                       :base_name,
                                       {
                                           position: ['position', :string_float]
                                       },
                                       {
                                           questions_total: ['questions_total', :string_integer]
                                       },
                                       {
                                           result: ['mask', :string_boolean_split_array]
                                       },
                                       {
                                           bonus_a: ['bonus_a', :string_integer]
                                       },
                                       {
                                           bonus_b: ['bonus_b', :string_integer]
                                       },
                                       {
                                           tech_rating: ['tech_rating', :string_integer]
                                       },
                                       {
                                           predicted_position: ['predicted_position', :string_integer]
                                       },
                                       {
                                           real_bonus_b: ['real_bonus_b', :string_integer]
                                       },
                                       {
                                           d_bonus_b: ['d_bonus_b', :string_integer]
                                       },
                                       {
                                           included_in_rating: ['included_in_rating', :string_boolean]
                                       }
                                   ],
                                   TEAM: [
                                       {
                                           id: 'idteam'
                                       },
                                       :name,
                                       :town,
                                       :comment
                                   ],
                                   TOURNAMENT_TEAM_RESULT: [
                                       {
                                           tour: ['tour', :string_integer]
                                       },
                                       {
                                           result: ['mask', :string_boolean_array]
                                       },
                                   ]
                               })
  end
end