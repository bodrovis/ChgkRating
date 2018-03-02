---
layout: default
---

Welcome! **ChgkRating** is a [Ruby](http://ruby-lang.org/) interface for the [rating.chgk.info](http://rating.chgk.info/index.php/api) WebAPI. This is not just a wrapper, but rather a quite complex opinionated client that allows to easily work with various API resources.

[Competitive CHGK (aka "What? Where? When?")](https://en.wikipedia.org/wiki/What%3F_Where%3F_When%3F#Competitive_game) is a popular intellectual game where teams of up to six people are trying to find an answers to various questions.

Documentation for all supported resources can be found in the right menu. All errors, feature requests and questions can be posted [via GitHub issue tracker](https://github.com/bodrovis/ChgkRating/issues).

## A Very Quick Example

```ruby
# Instantiate the client:
client = ChgkRating.client

# Get all players (first 1000):
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