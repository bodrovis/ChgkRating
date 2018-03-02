# Team Players at Tournament

## Team Players at Tournament - Collection

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

## Team Players at Tournament - Model

It is not possible to load information about a specific player at the given tournament, so use the `team_players_at_tournament` method listed above.

Note that `TournamentPlayer` **is a different model** which is not equal to the `Player` model. It has, however, the same id, so you may easily find the corresponding `Player` layer.

`TournamentPlayer` has the following getters:

```ruby
id          # String
is_captain  # Boolean
is_base     # Boolean
is_foreign  # Boolean
```