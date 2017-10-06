lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgk_rating'
require 'pry'
c = ChgkRating.client
#t = c.team 1, true
puts c.tournaments(team_id: 1).inspect
#binding.pry