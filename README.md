# ChgkRating

[![Build Status](https://travis-ci.org/bodrovis/ChgkRating.svg?branch=master)](https://travis-ci.org/bodrovis/ChgkRating)
[![Code Climate](https://codeclimate.com/github/bodrovis/ChgkRating/badges/gpa.svg)](https://codeclimate.com/github/bodrovis/ChgkRating)
[![Test Coverage](https://codeclimate.com/github/bodrovis/ChgkRating/badges/coverage.svg)](https://codeclimate.com/github/bodrovis/ChgkRating/coverage)
[![Dependency Status](https://gemnasium.com/bodrovis/ChgkRating.svg)](https://gemnasium.com/bodrovis/ChgkRating)

Ruby interface for the [rating.chgk.info](http://rating.chgk.info/index.php/api) WebAPI. This is not just a wrapper, but rather a complex full-fledged client that allows to easily work with various API resources.

[Competitive CHGK (aka "What? Where? When?")](https://en.wikipedia.org/wiki/What%3F_Where%3F_When%3F#Competitive_game) is a popular intellectual game where teams of up to six people are trying to find an answers to various questions.

## Installation and Requirements

This gem works **only** with Ruby 2.4+ and I have no plans of making it compatible with older versions. Apart from that, it has no special requirements.

Install it by running:

    $ gem install chgk_rating
    
## Usage

Remember that ChgkRating API is **read-only**.

### A Very Quick Example

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

### Before You Start

As long as this gem is not just a wrapper, there are a bunch of things that you might want to know before starting to use it. This information, however, is optional and if you just want to quickly fetch some info about a specific resource, ignore it.

* [Types of resources](https://github.com/bodrovis/ChgkRating/wiki/Types-of-resources) - explains what are models and collections are in terms of this gem and how to convert resources back to their raw form
* [Pagination](https://github.com/bodrovis/ChgkRating/wiki/Pagination) 
* [Lazy and eager loading](https://github.com/bodrovis/ChgkRating/wiki/Lazy-and-eager-loading) - explains why you might not see full information about some resource and how to forcibly load it

### Initializing the Client

Initialize the client with the following shortcut:

```ruby
client = ChgkRating.client
```

This method does not accept any arguments because the client requires no configuration. You don't need any API keys, access tokens and that stuff - just go ahead and send any queries you like. Seems like the API has no quota limitation as well but of course it does not mean you should abuse it.

Now you may utilize the `client` local variable to perform various requests described below.

### Players

#### Players - Collection

Returns an array-like `Players` object containing list of `Player` models sorted by their IDs:

```ruby
client.players params={} # Input:
                         # (optional) params - Hash
                         ## Supported params:
                         ## :page - Integer or String. The requested page. Default is 1, and there are 1000 results per page.
                         ## :lazy - Boolean. Should the Player models be marked as lazily loaded? Note that the models will still contain all the information returned by the API.
                         ## :collection - Enumerable. An array or collection of Players that will be used to build a new collection. If this option is provided, API request will not be sent. This param is mostly used for internal purposes, but you may take advantage of it as well.
```

Note that the information returned for each `Player` is a bit limited: specifically, `db_chgk_info_tag` and `comment` attributes are `nil` (actually, most players have no value for these attributes anyways). However, you are free to forcibly eager load one or more players:

```ruby
players = client.players.take(3)
players.map! {|p| p.eager_load! true}
```

#### Player - Model

Returns information about a single `Player`:

```ruby
client.player id, lazy=false # Input:
                             # id - Integer or String, player's id
                             # (optional) lazy - Boolean   
```

Getter methods:

```ruby
id               # String
name             # String
surname          # String
patronymic       # String
comment          # String
db_chgk_info_tag # String
```

Special notes:

* Can be lazily-loaded and eager-loaded.

#### Players - Search

Search for players by a given criteria:

```ruby
client.search_players params   # Input:
                               # params - Hash
                               ## Supported search params:
                               ## :name - String
                               ## :surname - String
                               ## :patronymic  - String
                               ## :page - String or Integer. Default is 1, and there are 1000 results per page.
```

Returns an array-like `Players::Search` collection consisting of `Player` models. 

### Teams

#### Teams - Collection

Get a list of all teams sorted by their IDs:

```ruby
client.teams params={}   # Input:
                         # (optional) params - Hash
                         ## Supported params:
                         ## :page - Integer or String. The requested page. Default is 1, and there are 1000 results per page.
                         ## :lazy - Boolean. Should the Team models be marked as lazily loaded? Note that the models will still contain all the information returned by the API.
                         ## :collection - Enumerable. An array or collection of Teams that will be used to build a new collection. If this option is provided, API request will not be sent. This param is mostly used for internal purposes, but you may take advantage of it as well.
```

Returns an array-like `Teams` object. A bit limited set of information is returned for each `Team` model: specifically, a `comment` attribute is set to `nil`.

#### Team - Model

Get full information about a single `Team`:

```ruby
client.team id, lazy=false # Input:
                           # id - Integer or String. Team's id
                           # (optional) lazy - Boolean    
```

Getter methods:

```ruby
id       # String
name     # String
town     # String
comment  # String
```

Special notes:

* Can be lazily-loaded and eager-loaded. 

##### Interface Methods

#### Teams - Search

Search for teams by a given criteria:

```ruby
client.search_teams params   # Input:
                             # params - Hash
                             ## Supported search params:
                             ## :name - String
                             ## :town - String
                             ## :page - String or Integer. Default is 1, and there are 1000 results per page.
```

Returns `Teams::Search` collection consisting of `Team` models. 

### Recap (Team's Roster)

The term "recap" is used by the ChgkRating API but I do not think it is suitable. Basically, it means "team's roster", "team list", or "team's lineup".

#### Recaps - Collection

Get recaps grouped by seasons for a single team:

```ruby
client.recaps team_or_id # Input:
                         # team_or_id - String, Integer or Team. Team to load recaps for.
```

Returns a hash-like `Recaps` object with the season numbers as the keys and the `Recap` model as values.
If the team has not participated in a season, it is **not** included in the response.

The `Recaps` collection responds to the following methods:

```ruby
team # Team - lazily-loaded Team model
```

#### Recap - Model

Get information about a team's recap in a given season:

```ruby
client.recap team_id, season_id # Input:
                                # team_or_id - String, Integer or Team
                                # season_id - Integer or String
```

Returns a `Recap` model that has the following getters:

```ruby
team        # Team - lazily-loaded model
season_id   # String
players     # Players collection consisting of lazily-loaded Player models
captain     # Player model, lazily-loaded
```

### Team Ratings

#### Team Ratings - Collection

Get all ratings for a single team:

```ruby
client.ratings team_or_id # Input:
                          # team_or_id - String, Integer or Team. Team to load ratings for.
```

Returns an array-like `Ratings` collection containing `Rating` models.

Collection responds to the following methods:

```ruby
team # Team - lazily-loaded model
```

#### Team Rating - Model

Get `Rating` for a team in a given release:

```ruby
client.rating team_or_id, release_id  # Input:
                                      # team_or_id - String, Integer or Team
                                      # release_id - String or Integer  
```

Getters:

```ruby
team            # Team - lazily-loaded model
release_id      # String
rating          # Integer
rating_position # Integer
date            # Date
formula         # Symbol - :a or :b
```

### Tournaments

#### Tournaments - Collection

```ruby
client.tournaments team_or_id: nil, season_id: nil, params: {} # Input (arguments are passed in a hash-like format):
                                                               # (optional) team_or_id - String, Integer or Team
                                                               # (optional) season_id - String or Integer
                                                               # (optional) params - Hash
                                                               ## Supported params:
                                                               ## :page - String or Integer. Default is 1
```

**When both `team_or_id` and `season_id` are not set**, returns an array-like `Tournaments` collection with all the tournaments. In this case `Tournament` models have only the following attributes set:

```ruby
id          # String
name        # String
date_start  # Date
date_end    # Date
type_name   # String
```

**When only `team_or_id` is set**, returns a hash-like `Tournaments` collection. This collection has season numbers as keys and array of `Tournament` models as values. `Tournament` models are lazily-loaded and have only `id` attribute set.

**When both `team` and `season_id` are set**, returns an array-like `Tournaments` collection with lazily-loaded `Tournament` models that have only `id` attribute set.

The collection responds to the following methods:

```ruby
team        # Nil or lazily-loaded Team
season_id   # Nil or String
```

#### Tournament - Model

Get information about a single tournament:

```ruby
client.tournament id, lazy=false  # Input:
                                  # id - Integer or String
                                  # (optional) lazy - Boolean
```

`Tournament` has the following getters:

```ruby
id                        # String
name                      # String
date_start                # DateTime
date_end                  # DateTime
type_name                 # String
town                      # String
long_name                 # String
tour_count                # Integer
tour_questions            # Integer
tour_ques_per_tour        # Integer
questions_total           # Integer
type_name                 # String
main_payment_value        # Float
discounted_payment_value  # Float
discounted_payment_reason # String
date_requests_allowed_to  # DateTime
comment                   # String
site_url                  # URI
```

Special notes:

* Lazy-loading and eager-loading is supported.

### Teams at Tournament

#### Teams at Tournament - Collection

Get a list of all teams which participated in a given tournament:

```ruby
client.teams_at_tournament tournament_or_id  # Input:
                                             # tournament_id - Integer, String or Tournament
```

Returns an array-like `TournamentTeams` collection that responds to the following methods:

```ruby
tournament # Tournament. Lazily-loaded model
```

#### Team at Tournament - Model

Instantiate a `TournamentTeam` model:

```ruby
client.team_at_tournament tournament_or_id, team_or_id # Input:
                                                       # tournament_or_id - Integer, String or Tournament
                                                       # team_or_id -  Integer, String or Team
```

Note that this method **always** returns a lazily-loaded model that cannot be eager-loaded later. This is
because the API does not allow to fetch information for a single tournament team. Therefore only the following
attributes are set:

```ruby
id              # String 
tournament      # Tournament. Lazily-loaded model
```

This `TournamentTeam` object, however, can be used to perform interface methods listed below. 

`TournamentTeam` models loaded with the `teams_at_tournament` method (see above) have the following attributes:

```ruby
id                  # String
current_name        # String
base_name           # String
position            # Float
questions_total     # Integer
Result              # Array - contains Boolean values. Each value corresponds to a single question and
                    # marks whether the team answered this question or not. The length of the array equals to the
                    # value returned by the questions_total method 
bonus_a             # Integer
bonus_b             # Integer
tech_rating         # Integer
predicted_position  # Integer
real_bonus_b        # Integer
d_bonus_b           # Integer
included_in_rating  # Boolean
```

### Team Results at Tournament

#### Team Results at Tournament - Collection

Get team results at a given tournament:

```ruby
client.team_results_at_tournament tournament_or_id, team_or_id # Input:
                                                               # tournament_or_id - Integer, String or Tournament
                                                               # team_or_id -  Integer, String or Team
```

Returns an array-like `TournamentTeamResults` collection with `TournamentTeamResult` models. Each model contains results for a single tour. 

The collection responds to the following methods:

```ruby
team       # Team. Lazily-loaded model
tournament # Tournament. Lazily-loaded model
```

#### Team Result at Tournament - Model

API does not allow to load team result for a given tour separately, so use the `team_results_at_tournament` method listed above.

`TournamentTeamResult` model has the following getters:

```ruby
tour    # Integer
result  # Array containing Boolean values. Each value corresponds to a single question and
        # says whether the team answered the question or not
```

### Team Players at Tournament

#### Team Players at Tournament - Collection

Get information about the team's roster at the given tournament:

```ruby
client.team_players_at_tournament tournament_or_id, team_or_id  # Input:
                                                                # tournament_or_id - Integer, String or Tournament
                                                                # team_or_id -  Integer, String or Team
```

Returns an array-like `TournamentPlayers` collection containing `TournamentPlayer` models (each model represents one player).

The collection responds to the following getters: 

```ruby
id              # String
tournament      # Tournament. Lazily-loaded model
```

#### Team Players at Tournament - Model

It is not possible to load information about a specific player at the given tournament, so use the `team_players_at_tournament` method listed above.

Note that `TournamentPlayer` **is a different model** which is not equal to the `Player` model. It has, however, the same id, so you may easily find the corresponding `Player` layer.

`TournamentPlayer` has the following getters:

```ruby
id          # String
is_captain  # Boolean
is_base     # Boolean
is_foreign  # Boolean
```

## Testing

Tests run against mock responses so you don't need to perform any special setup. Simply pull the code and run:

    $ bundle install
    $ rspec . 

## License

This plugin is licensed under the [MIT License](https://github.com/bodrovis/ChgkRating/blob/master/LICENSE).

Copyright (c) 2017 [Ilya Bodrov](http://bodrovis.tech)
