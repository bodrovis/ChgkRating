require 'faraday'
require 'multi_json'

require 'chgk_rating/version'
require 'chgk_rating/connection'
require 'chgk_rating/request'

require 'chgk_rating/models/base'
require 'chgk_rating/models/player'
require 'chgk_rating/models/team'
require 'chgk_rating/models/recap'

require 'chgk_rating/collections/base'
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