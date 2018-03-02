# Players

## Players - Collection

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

## Player - Model

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

## Players - Search

Search for players by a given criteria:

```ruby
client.search_players params   # Input:
                               # params - Hash
                               ## Supported search params:
                               ## :name - String
                               ## :surname - String
                               ## :patronymic  - String
                               ## :page - String or Integer. Default is 1, and there are 1000 results per page.
```

Returns an array-like `Players::Search` collection consisting of `Player` models. 