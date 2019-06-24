# ChgkRating

[![Gem Version](https://badge.fury.io/rb/chgk_rating.svg)](https://badge.fury.io/rb/chgk_rating)
[![Build Status](https://travis-ci.org/bodrovis/ChgkRating.svg?branch=master)](https://travis-ci.org/bodrovis/ChgkRating)
[![Code Climate](https://codeclimate.com/github/bodrovis/ChgkRating/badges/gpa.svg)](https://codeclimate.com/github/bodrovis/ChgkRating)

Ruby interface for the [rating.chgk.info](http://rating.chgk.info/index.php/api) WebAPI. This is not just a wrapper, but rather a quite complex opinionated client that allows to easily work with various API resources.

[Competitive CHGK (aka "What? Where? When?")](https://en.wikipedia.org/wiki/What%3F_Where%3F_When%3F#Competitive_game) is a popular intellectual game where teams of up to six people are trying to find an answers to various questions.

The main documentation can be found at the [official website](http://chgk-rating.bodrovis.tech/).

Документация на русском языке также доступна на [официальном сайте](http://chgk-rating.bodrovis.tech/index_ru).

Documentation can also be found on [RubyDoc](http://www.rubydoc.info/github/bodrovis/ChgkRating/master).

## Installation and Requirements

This gem works **only** with Ruby 2.4+ and I have no plans of making it compatible with older versions. Apart from that, it has no special requirements.

Install it by running:

    $ gem install chgk_rating
    
## A Very Quick Example

```ruby
# Instantiate the client:
client = ChgkRating.client

# Get all players:
client.players 

# Get a specific team:
team = client.team 1 

# Get information about the team at a given tournament:
team.at_tournament 1000 

# Get results for the given team as the tournament:
team.at_tournament(1000).results

# The same data can be fetched with: 
client.team_results_at_tournament 1000, team

# Or you can even grab the tournament and pass it later:
tournament = client.tournament 1000

team.at_tournament(tournament).results
# OR
client.team_results_at_tournament tournament, team
```

## Testing

Tests run against mock responses so you don't need to perform any special setup. Simply pull the code and run:

    $ bundle install
    $ rspec . 

## License

This plugin is licensed under the [MIT License](https://github.com/bodrovis/ChgkRating/blob/master/LICENSE).

Copyright (c) [Ilya Bodrov](http://bodrovis.tech)
