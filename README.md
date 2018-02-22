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
```

Returns `Players` collection. 

Special notes:

* The result is paginated.

### Teams

#### Teams - Collection

Get a list of all teams sorted by their ids:

```ruby
client.teams params={} # Input:
                       # (optional) params - Hash
```

Returns an array-like `Teams` object. A limited set of information is returned for each `Team` model:

```ruby
id       # String
name     # String
town     # String
```

To get a bit more detailed information for a specific team, use the `team` method.

Special notes:

* The results are paginated by the API.
* Searching is supported.

#### Team - Model

Get full information about a single team:

```ruby
client.team id, lazy=false # Input:
                           # id - Integer, team's id
                           # (optional) lazy - Boolean    
```

The following information is available for each `Team`:

```ruby
id       # String
name     # String
town     # String
comment  # String
```

Special notes:

* Can be lazily-loaded.
* Can be eager-loaded. 

##### Interface Methods

#### Teams - Search

Search for teams by a given criteria:

```ruby
client.search_teams params   # Input:
                             # params - Hash
                             ## Supported search params:
                             ## :name - String
                             ## :town - String
```

Returns `Teams` collection. 

Special notes:

* The result is paginated.

### Recap (Team's Roster)

The term "recap" is used by the ChgkRating API but I do not think it is really suitable here.
It basically means "team's roster", "team list", or "team's lineup".

#### Recaps - Collection

Get recaps for all the seasons for a single team:

```ruby
client.recaps team_id # Input:
                      # team_id - Integer
```

Returns a hash-like `Recaps` object with the season numbers as the keys and the `Recap` model as values.
If the team has not played in some season, it is **not** included in the response. Each `Recap` model responds
to the methods listed in the Models section below.

The `Recaps` collection itself responds to the following methods:

```ruby
team_id # String
```

#### Recap - Model

Get information about a team's recap in a given season:

```ruby
client.recap team_id, season_id # Input:
                                # team_id - Integer or String
                                # season_id - Integer or String
```

Returns an `Recap` model that has the following accessors:

```ruby
team_id     # String
season_id   # String
players     # Players collection, lazily-loaded. Each Player model inside has only an id specified, all other attributes are nil
captain     # Player model, lazily-loaded. Has only id specified
```

### Team Ratings

#### Team Ratings - Collection

Get all ratings for a team:

```ruby
client.ratings team_id # Input:
                       # team_id - String or Integer
```

Returns an array-like `Ratings` collection containing `Rating` models.
Collection responds to the following methods:

```ruby
team_id # String or Integer - id of the team
```

Each `Recap` model responds to the methods listed in the next section.

#### Team Rating - Model

Get rating for a team in a given release:

```ruby
client.rating team_id, release_id  # Input:
                                   # team_id - String or Integer
                                   # release_id - String or Integer  
```

Responds to the following accessors:

```ruby
team_id         # String
release_id      # String
rating          # Integer
rating_position # Integer
date            # Date
formula         # Symbol - :a or :b
```

### Tournaments

#### Tournaments - Collection

```ruby
client.tournaments team: nil, season_id: nil, params: {} # Input (arguments are passed in a hash-like format):
                                                         # (optional) team - String, Integer or Team
                                                         # (optional) season_id - String or Integer
                                                         # (optional) params - Hash
```

The collection responds to the following methods:

```ruby
team        # Nil or lazily-loaded Team containing only id
season_id   # Nil or String
```

**When `team` and `season_id` are not set**, returns an array-like `Tournaments` collection with all the
tournaments from the database. In this case `Tournament` models have only the following attributes set:

```ruby
id          # String
name        # String
date_start  # Date
date_end    # Date
type_name   # String
```

**When only `team` is set**, returns a hash-like `Tournaments` collection. This collection has season numbers
as keys and nested `Tournaments` collections as values. `Tournament` models inside the nested collections are
lazily-loaded and has only one attribute set:

```ruby
id  # String
```

**When both `team` and `season_id` are set**, returns an array-like `Tournaments` collection with
lazily-loaded `Tournament` models that have the following attributes set:

```ruby
id  # String
```

Special notes:

* The results are paginated.

#### Tournament - Model

Get information about a single tournament:

```ruby
client.tournament id, lazy=false  # Input:
                                  # id - Integer or String
                                  # (optional) lazy - Boolean
```

`Tournament` has the following attributes:

```ruby
id                        # String
name                      # String
date_start                # Date
date_end                  # Date
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
date_requests_allowed_to  # Date
comment                   # String
site_url                  # URI
```

Special notes:

* Lazy-loading and eager-loading is supported.

### Teams at Tournament

#### Teams at Tournament - Collection

Get a list of all teams which participated in a given tournament:

```ruby
client.teams_at_tournament tournament_id  # Input:
                                          # tournament_id - Integer or String
```

Returns an array-like `TournamentTeams` collection that responds to the following methods:

```ruby
tournament_id # String
```

`TournamentTeam` models respond to the methods listed in the next section.

#### Team at Tournament Model

Instantiate a `TournamentTeam` model:

```ruby
client.team_at_tournament tournament_id, team_id
```

Note that this method **always** returns a lazily-loaded model that cannot be eager-loaded later. This is
because the API does not allow to fetch information about a single tournament team. Therefore only the following
attributes are set:

```ruby
id              # String 
tournament_id   # String
```

This `TournamentTeam` object, however, can be used to perform interface methods listed below. 

`TournamentTeam` models loaded with the `teams_at_tournament` method (see above) have the following attributes:

```ruby
id                  # String
current_name        # String
base_name           # String
position            # Integer
questions_total     # Integer
mask                # Array - contains Boolean values. Each value corresponds to a single question and
                    # says whether the team answered the question or not. The length of the array equals to the
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
client.team_results_at_tournament tournament_id, team_id
```

Returns an array-like `TournamentTeamResults` collection with `TournamentTeamResult` models.
Each model has results for a single tour.
The collection responds to the following methods:

```ruby
team_id
tournament_id
```

#### Team Result at Tournament Model

You cannot load team result for a given tour separately, so use the `team_results_at_tournament` method
listed above.

`TournamentTeamResult` model has the following readers:

```ruby
tour    # Integer
result  # Array containing Boolean values. Each value corresponds to a single question and
        # says whether the team answered the question or not
```

### Team Players at Tournament

#### Team Players at Tournament - Collection

Get information about the team's roster at the given tournament:

```ruby
client.team_players_at_tournament tournament_id, team_id  # Input:
                                                          # tournament_id - Integer or String
                                                          # team_id - Integer or String 
```

Returns an array-like `TournamentPlayers` collection containing `TournamentPlayer` models (each model represents one player).
The collection responds to the following methods: 

```ruby
team_id        # String
tournament_id  # String
```

#### Team Players at Tournament - Model

It is not possible to load information about a specific player at the given tournament, so use the
`team_players_at_tournament` method listed above.

`TournamentPlayer` model has the following readers:

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
