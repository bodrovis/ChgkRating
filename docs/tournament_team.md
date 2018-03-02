# Teams at Tournament

## Teams at Tournament - Collection

Get a list of all teams which participated in a given tournament:

```ruby
client.teams_at_tournament tournament_or_id  # Input:
                                             # tournament_id - Integer, String or Tournament
```

Returns an array-like `TournamentTeams` collection that responds to the following methods:

```ruby
tournament # Tournament. Lazily-loaded model
```

## Team at Tournament - Model

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
result              # Array - contains Boolean values. Each value corresponds to a single question and
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

### Interface Methods

`TournamentTeam` model respond to the following convenience methods:

```ruby
tournament_team.players # Returns an array-like TournamentPlayers collection containing roster for the current TournamentTeam

tournament_team.results # Returns an array-like TournamentTeamResults collection containing results for the current TournamentTeam
```