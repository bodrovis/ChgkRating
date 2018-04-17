# Team Ratings

## Collection

Get all ratings for a single team:

```ruby
client.team_ratings team_or_id # Input:
                               # team_or_id - String, Integer or Team. Team to load ratings for.
```

Get all ratings for a single player:

```ruby
client.player_ratings player_or_id # Input:
                                   # player_or_id - String, Integer or Player. Player to load ratings for.
```

Returns an array-like `Ratings` collection containing `Rating` models.

Collection responds to the following methods:

```ruby
team   # Team - lazily-loaded model
player # Player - lazily-loaded model
```

## Model

Get `Rating` for a team in a given release:

```ruby
client.team_rating team_or_id, release_id  # Input:
                                           # team_or_id - String, Integer or Team
                                           # release_id - String or Integer  
```

Get `Rating` for a player in a given release:

```ruby
client.player_rating player_or_id, release_id  # Input:
                                               # player_or_id - String, Integer or Player
                                               # release_id - String or Integer  
```

Getters:

```ruby
team                    # Team - lazily-loaded model
player                  # Player - lazily-loaded model
release_id              # String
rating                  # Integer
rating_position         # Integer
date                    # Date
formula                 # Symbol - :a or :b
tournaments_in_year     # Integer - number of tournaments played this year (only for player)
tournament_count_total  # Integer - total number of tournaments played (only for player)
```