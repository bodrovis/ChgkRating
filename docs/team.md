# Teams

## Collection

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

## Model

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

### Interface Methods

`Team` model respond to the following convenience methods:

```ruby
team.recap(season_id)                        # Returns a single Recap for the current Team at a given season. Input:
                                             # season_id - Integer or String

team.at_tournament(tournament_or_id)         # Returns TournamentTeam model that contains information about the
                                             # team's results at the given tournament. Input:
                                             # tournament_or_id - String, Integer or Tournament

team.rating(release_id)                      # Returns Rating for the current Team in a given release. Input:
                                             # release_id - String or Integer

team.ratings                                 # Returns an array-like Ratings collection for the current team.

team.recaps                                  # Returns an hash-like Recaps collection for the current team, grouped by seasons. Seasons act
                                             # as keys, whereas Recap models - as values.

team.tournaments(season_id: nil, params: {}) # Returns a collection of Tournaments that the current team participated at
                                             # based on the given criteria. Input:
                                             # (optional) season_id - Integer or String
                                             # (optional) params - Hash
                                             ## Supported params:
                                             ## :page - String or Integer. Default is 1
```

## Search

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