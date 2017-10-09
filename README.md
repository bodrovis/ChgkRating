# ChgkRating

[![Build Status](https://travis-ci.org/bodrovis/ChgkRating.svg?branch=master)](https://travis-ci.org/bodrovis/ChgkRating)
[![Code Climate](https://codeclimate.com/github/bodrovis/ChgkRating/badges/gpa.svg)](https://codeclimate.com/github/bodrovis/ChgkRating)
[![Test Coverage](https://codeclimate.com/github/bodrovis/ChgkRating/badges/coverage.svg)](https://codeclimate.com/github/bodrovis/ChgkRating/coverage)
[![Dependency Status](https://gemnasium.com/bodrovis/ChgkRating.svg)](https://gemnasium.com/bodrovis/ChgkRating)

Ruby interface for the [rating.chgk.info](http://rating.chgk.info/index.php/api) WebAPI.  

[Competitive CHGK (aka What? Where? When?)](https://en.wikipedia.org/wiki/What%3F_Where%3F_When%3F#Competitive_game)
is a popular intellectual game where teams of up to six people are trying to find an answers to various questions.

## Installation and Requirements

This gem is tested against Ruby 2.2.8, 2.3.5 and 2.4.2. It has no special requirements.

Install it by running:

    $ gem install chgk_rating
    
## Usage

Remember that ChgkRating API is **read-only**.

### Initializing the Client

The client can be initialized with the following shortcut:

```ruby
client = ChgkRating.client
```

This method does not accept any arguments because the client requires no configuration. You don't need any API keys, access tokens and that stuff - just go ahead and send any queries you like. It does not seem like the API has any quota limitation as well but of course it does not mean you should abuse it.

So, now you may use the `client` local variable to perform various requests described below.

### Players

#### Collection

Get a list of all players sorted by their ids:

```ruby
client.players
```

Returns an array-like `Players` object that can be iterated using the `each` method. Individual players
can be accessed using the `[]`:

```ruby
client.players[100]
```

Only the following information is returned for each player:

```ruby
id          # string
name        # string
surname     # string
patronymic  # string
```

To get a more detailed information for a specific team, use the `player` method.

Special notes:

* The results are paginated by the API.
* Searching is supported.
* Can be lazily-loaded. 

#### Individual Player

Get information about a player with an id of `1`:

```ruby
client.player 1
```

Full information about the player will be returned in this case:

```ruby
id               # string
name             # string
surname          # string
patronymic       # string
comment          # string
db_chgk_info_tag # string
```

Special notes:

* Can be lazily-loaded. 

### Teams

#### Collection

Get a list of all teams sorted by their ids:

```ruby
client.teams
```

Returns an array-like `Teams` object that can be iterated using the `each` method. Individual teams
can be accessed using the `[]`:

```ruby
client.teams[10]
```

A limited set of information is returned for each team:

```ruby
id       # string
name     # string
town     # string
```

To get a bit more detailed information for a specific team, use the `team` method.

Special notes:

* The results are paginated by the API.
* Searching is supported.
* Models can be lazily-loaded. 

#### Individual Team

Get information about a team with an id of `1`:

```ruby
client.team 1
```

Full information will be returned in this case:

```ruby
id       # string
name     # string
town     # string
comment  # string
```

Special notes:

* Can be lazily-loaded.
* Can be eager-loaded. 

##### Interface Methods

### Recap (Team's Roster)

The term "recap" is used by the ChgkRating API but I do not think it is really suitable here.
It basically means "team's roster", "team list", or "team's lineup".

#### Collection

Get recaps for all the seasons for a team `1`:

```ruby
client.recaps 1 # Accepts season's id or :last value to get recaps for the most recent season
```

Returns a hash-like `Recaps` object with the season numbers as the keys and the `Recap` objects as values.
If the team has not played in some season, it is **not** included in the response. Each `Recap` responds
to the method listed in the Models section below.

The collection itself responds to the `team_id` method that returns the team's id (`string`).
It also supports `[]` and `each` methods, just like any other hash.

Special notes:

* The results are not paginated.
* Search, lazy-loading and eager-loading is not supported.

#### Models

Get information about a team's `1` recap in a season `9`:

```ruby
client.team 1, 9 
```

Returns an `Recap` object that has the following accessors:

```ruby
team_id     # id of the team (string)
season_id   # season id (string)
players     # Lazily-loaded Players collection. Each Player only has an id specified, all other attributes are nil
captain     # Lazily-loaded Player model (has only id specified)
```

Special notes:

* Lazy-loading and eager-loading is not supported.

### Team's Rating 

#### Collection

Get all ratings for a team:

```ruby
client.ratings 1 # Input:
                 # team_id (string or integer)
```

Returns an array-like `Ratings` collection containing `Recap` models.
Collection responds to the following methods:

```ruby
team_id # id of the team (string or integer)
```

Each `Recap` model responds to the methods listed in the next section.

Special notes:

* The results are not paginated.
* Search, lazy-loading and eager-loading is not supported.

#### Model

Get rating for a team in a release `9`:

```ruby
client.rating 1, 9  # Input:
                    # team_id (String or Integer)
                    # release_id (String or Integer)  
```

Responds to the following accessors:

```ruby
team_id         # String
release_id      # String
rating          # Integer
rating_position # Integer
date            # Date
formula         # Symbol (:a or :b)
```

Special notes:

* Lazy-loading and eager-loading is not supported.

## Tournaments

Special notes:

* The results are paginated.
* Models can be lazily-loaded.

## Testing

Tests run against mock responses so you don't need to perform any special setup. Simply pull the code and run:

    $ bundle install
    $ rspec . 

## License

This plugin is licensed under the [MIT License](https://github.com/bodrovis/ChgkRating/blob/master/LICENSE).

Copyright (c) 2017 [Ilya Bodrov](http://bodrovis.tech)
