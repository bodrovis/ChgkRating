# Recap (Team's Roster)

The term "recap" is used by the ChgkRating API but I do not think it is suitable. Basically, it means "team's roster", "team list", or "team's lineup".

## Recaps - Collection

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

## Recap - Model

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