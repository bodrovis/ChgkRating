module ChgkRating
  module AttributeMappings
    extend ChgkRating::Utils::Transformations

    class << self
      def find(name)
        const_get name.snakecase_upcase
      end

      def generate_mappings_for(data)
        data.each do |const_name, raw_schemes|
          const_set const_name, generate_mapping_for(raw_schemes)
        end
      end

      private

      def name_from(raw_name)
        { raw_name: raw_name.to_s }
      end

      def parse_raw_scheme(raw_scheme)
        if raw_scheme.respond_to? :inject
          scheme_from raw_scheme
        else
          { raw_scheme => name_from(raw_scheme) }
        end
      end

      def scheme_from(raw_scheme)
        raw_scheme.inject({}) do |memo, (key, value)|
          memo[key] = scheme_value_from key, value
          memo
        end
      end

      def scheme_value_from(key, raw_value)
        if raw_value.is_a? String
          name_from raw_value
        else
          raw_value = [key.to_s] if raw_value[0].nil? # for cases like `rating: []`
          name_from(raw_value[0]).merge transformation(raw_value[1])
        end
      end

      def generate_mapping_for(raw_schemes)
        return unless raw_schemes&.any?

        if raw_schemes.is_a? Array
          raw_schemes.inject({}) do |memo, raw_scheme|
            memo.merge parse_raw_scheme(raw_scheme)
          end
        else
          parse_raw_scheme raw_schemes
        end.freeze
      end
    end

    generate_mappings_for({
                              PLAYER: [
                                  { id: 'idplayer' },
                                  :name,
                                  :surname,
                                  :patronymic,
                                  :comment,
                                  :db_chgk_info_tag
                              ],
                              RATING: {
                                  team: ['idteam', :team_id],
                                  player: ['idplayer', :player_id],
                                  release_id: 'idrelease',
                                  rating: [],
                                  tournaments_in_year: [],
                                  tournament_count_total: [],
                                  rating_position: [],
                                  date: ['date', :date],
                                  formula: ['formula', :sym]
                              },
                              RECAP: {
                                  season_id: 'idseason',
                                  team: ['idteam', :team_id],
                                  captain: ['captain', :player_id],
                                  players: ['players', :players_ids]
                              },
                              TOURNAMENT: [
                                  {
                                      id: 'idtournament',
                                      team: ['idteam', :team_id],

                                      date_start: ['date_start', :datetime],
                                      date_end: ['date_end', :datetime],
                                      tour_count: [],
                                      tour_questions: [],
                                      tour_ques_per_tour: [],
                                      questions_total: [],
                                      main_payment_value: ['main_payment_value', :float],
                                      discounted_payment_value: ['discounted_payment_value', :float],
                                      date_requests_allowed_to: ['date_requests_allowed_to', :datetime],
                                      site_url: ['site_url', :uri]
                                  },
                                  :name,
                                  :town,
                                  :long_name,
                                  :type_name,
                                  :discounted_payment_reason,
                                  :comment
                              ],
                              TOURNAMENT_PLAYER: {
                                  id: 'idplayer',
                                  is_captain: ['is_captain', :boolean_binboolean],
                                  is_base: ['is_base', :boolean_binboolean],
                                  is_foreign: ['is_foreign', :boolean_binboolean]
                              },
                              TOURNAMENT_TEAM: [
                                  {
                                      id: 'idteam',
                                      position: ['position', :float],
                                      questions_total: [],
                                      result: ['mask', :splitboolean_arraystrboolean],
                                      bonus_a: [],
                                      bonus_b: [],
                                      tech_rating: [],
                                      predicted_position: [],
                                      d_bonus_a: [],
                                      d_bonus_b: [],
                                      d_diff_bonus: [],
                                      included_in_rating: ['included_in_rating', :boolean_binboolean]
                                  },
                                  :current_name,
                                  :base_name
                              ],
                              TEAM: [
                                  { id: 'idteam' },
                                  :name,
                                  :town,
                                  :comment
                              ],
                              TOURNAMENT_TEAM_RESULT: {
                                  tour: [],
                                  result: ['mask', :arrayboolean_arraystrboolean]
                              }
                          })
  end
end