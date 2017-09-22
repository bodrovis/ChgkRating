lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgk_rating'

c = ChgkRating.client
t = c.team_results_at_tournament(3506, 52926)
puts t.inspect