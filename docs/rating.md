# Team Ratings

## Team Ratings - Collection

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

## Team Rating - Model

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