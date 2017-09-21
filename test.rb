lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgk_rating'

c = ChgkRating.client
puts ChgkRating::Collections::Teams.search(name: 'э', page: 2).first.name