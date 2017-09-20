lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgk_rating'

c = ChgkRating.client
puts c.recaps(1).inspect