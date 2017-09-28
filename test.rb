lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgk_rating'

c = ChgkRating.client
t = c.teams(page: 2).first
puts t.inspect