# frozen_string_literal: true

module ChgkRating
  module AttributeMappings
    extend ChgkRating::Utils::Transformations

    class << self
      def find(name)
        const_get name.snakecase_upcase
      rescue NameError
        {}
      end

      def generate_mappings_for(data)
        data.each do |const_name, raw_schemes|
          const_set const_name, generate_mapping_for(raw_schemes)
        end
      end

      private

      def name_from(raw_name)
        {raw_name: raw_name.to_s}
      end

      def parse_raw_scheme(raw_scheme)
        if raw_scheme.respond_to? :inject
          scheme_from raw_scheme
        else
          {raw_scheme => name_from(raw_scheme)}
        end
      end

      def scheme_from(raw_scheme)
        raw_scheme.each_with_object({}) do |(key, value), memo|
          memo[key] = scheme_value_from key, value
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
          raw_schemes.reduce({}) do |memo, raw_scheme|
            memo.merge parse_raw_scheme(raw_scheme)
          end
        else
          parse_raw_scheme raw_schemes
        end.freeze
      end
    end

    generate_mappings_for({
                            PLAYER: [
                              {id: 'idplayer'},
                              :name,
                              :surname,
                              :patronymic,
                              :comment,
                              :db_chgk_info_tag
                            ],
                            RATING: {
                              release_id: 'idrelease',
                              rating: [],
                              rating_position: [],
                              tech_rating: [],
                              date: ['date', :date]
                            },
                            PLAYER_RATING: {
                              player: ['idplayer', :player_id],
                              tournaments_in_year: [],
                              tournament_count_total: []
                            },
                            TEAM_RATING: {
                              team: ['idteam', :team_id],
                              formula: ['formula', :sym]
                            },
                            RECAP: {
                              season_id: 'idseason',
                              team: ['idteam', :team_id],
                              captain: ['captain', :player_id],
                              players: ['players', :players_ids]
                            },
                            PLAYER_TOURNAMENT: [
                              tournament: ['idtournament', :tournament_id],
                              team: ['idteam', :team_id],
                              in_base_team: ['in_base_team', :boolean_binboolean]
                            ],
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
                                tournament_in_rating: ['tournament_in_rating', :boolean_binboolean],
                                date_requests_allowed_to: ['date_requests_allowed_to', :datetime],
                                site_url: ['site_url', :uri],
                                date_archived_at: ['date_archived_at', :datetime]
                              },
                              :name,
                              :town,
                              :long_name,
                              :type_name,
                              :main_payment_currency,
                              :discounted_payment_currency,
                              :discounted_payment_reason,
                              :archive,
                              :comment
                            ],
                            TOURNAMENT_TEAM_PLAYER: {
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
                                bonus_b: [],
                                tech_rating_rt: [],
                                tech_rating_rg: [],
                                tech_rating_rb: [],
                                rating_r: [],
                                predicted_position: [],
                                diff_bonus: [],
                                included_in_rating: ['included_in_rating', :boolean_binboolean]
                              },
                              :current_name,
                              :base_name
                            ],
                            TEAM: [
                              {
                                id: 'idteam',
                                tournaments_this_season: [],
                                tournaments_total: []
                              },
                              :name,
                              :town,
                              :region_name,
                              :country_name,
                              :comment
                            ],
                            TOURNAMENT_TEAM_RESULT: {
                              tour: [],
                              result: ['mask', :arrayboolean_arraystrboolean]
                            }
                          })
  end
end
