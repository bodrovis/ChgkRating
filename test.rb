lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgk_rating'
require 'pry'
c = ChgkRating.client
t = c.recap 1, 9
#t_t = t.at_tournament 3506
#r = t_t.results.first
#binding.pry
#r = c.recaps t
binding.pry
#binding.pry