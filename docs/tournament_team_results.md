# Team Results at Tournament

## Collection

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

## Model

API does not allow to load team result for a given tour separately, so use the `team_results_at_tournament` method listed above.

`TournamentTeamResult` model has the following getters:

```ruby
tour    # Integer
result  # Array containing Boolean values. Each value corresponds to a single question and
        # says whether the team answered the question or not
```