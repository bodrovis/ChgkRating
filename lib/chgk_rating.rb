require 'date'
require 'uri'
require 'faraday'
require 'multi_json'

require 'ext/date'
require 'ext/date_time'
require 'ext/uri'

require 'chgk_rating/utils/transformations'
require 'chgk_rating/utils/snakecase'

require 'chgk_rating/version'
require 'chgk_rating/error'
require 'chgk_rating/connection'
require 'chgk_rating/request'
require 'chgk_rating/attribute_mappings'

require 'chgk_rating/concerns/searching'

require 'chgk_rating/chgk_object'

require 'chgk_rating/models/base'
require 'chgk_rating/models/tournament/tournament_team_result'
require 'chgk_rating/models/tournament/tournament_team_player'
require 'chgk_rating/models/tournament/tournament_team'
require 'chgk_rating/models/tournament/player_tournament'
require 'chgk_rating/models/tournament/tournament'
require 'chgk_rating/models/rating/rating'
require 'chgk_rating/models/rating/player_rating'
require 'chgk_rating/models/rating/team_rating'
require 'chgk_rating/models/player'
require 'chgk_rating/models/team'
require 'chgk_rating/models/recap'

require 'chgk_rating/collections/base'
require 'chgk_rating/collections/tournaments/tournament_team_results'
require 'chgk_rating/collections/tournaments/tournament_team_players'
require 'chgk_rating/collections/tournaments/tournament_teams'
require 'chgk_rating/collections/tournaments/player_tournaments'
require 'chgk_rating/collections/tournaments/tournaments'
require 'chgk_rating/collections/ratings/player_ratings'
require 'chgk_rating/collections/ratings/team_ratings'
require 'chgk_rating/collections/players'
require 'chgk_rating/collections/teams'
require 'chgk_rating/collections/recaps'

require 'chgk_rating/client'

module ChgkRating
  # Initializes a new Client object
  #
  # @return [ChgkRating::Client]
  def self.client
    @client ||= ChgkRating::Client.new
  end
end