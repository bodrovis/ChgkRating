# Tournaments

## Tournaments - Collection

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

## Tournament - Model

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

### Interface Methods

`Tournament` model respond to the following convenience methods:

```ruby
tournament.team_players(team_or_id) # Returns an array-like TournamentPlayers collection containing roster
                                    # for a team at the current tournament. Input:
                                    # team_or_id - String, Integer or Team

tournament.team_results(team_or_id) # Returns an array-like TournamentTeamResults collection with results
                                    # for a given team in the current tournament. Input:
                                    # team_or_id - String, Integer or Team

tournament.team_list                # Returns an array-like TournamentTeams collection specifying which
                                    # teams participated in the current tournament

tournament.team(team_or_id)         # Returns information about a single TournamentTeam in the current tournament
                                    # team_or_id - String, Integer or Team
```