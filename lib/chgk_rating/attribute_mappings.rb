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
        mapping = {}
        if raw_scheme.respond_to? :each
          # key - symbol
          # value - string or array
          raw_scheme.each do |key, value|
            if value.is_a?(String)
              mapping[key] = name_from(value)
            elsif value.is_a?(Array)
              # value[0] - string, raw key name
              # value[1] - symbol, model name that turns to method name (eg, team_model)
              value = [key.to_s] if value[0].nil? # for cases `rating: []`
              mapping[key] = name_from(value[0]).merge transformation(value[1])
            end
          end
        else
          mapping[raw_scheme] = name_from(raw_scheme)
        end
        mapping
      end

      def generate_mapping_for(raw_schemes)
        return unless raw_schemes&.any?

        if raw_schemes.is_a? Array
          raw_schemes.inject({}) do |memo, raw_scheme|
            # raw_scheme - hash or symbol
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
                                  release_id: 'idrelease',
                                  rating: [],
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
                                  is_captain: ['is_captain', :boolean],
                                  is_base: ['is_base', :boolean],
                                  is_foreign: ['is_foreign', :boolean]
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
                                      real_bonus_b: [],
                                      d_bonus_b: [],
                                      included_in_rating: ['included_in_rating', :boolean]
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