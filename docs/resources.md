# Available Types of Resources

Resources represent objects returned by the API. For example, there is a resource called `Team` or `Tournaments` which are pretty self-explanatory. There are two types of resources listed below.

## Model

Object representing a single entity: for instance, a player or a team. It has a handful of attributes and may also respond to various interface methods. For example:

```ruby
team = client.team 1 # Fetch team with an ID of 1
team.name # Get the team's name. That's a simple getter method
team.recap(10) # Get team's recap (roster) at season 10. This is an interface method that returns another collection
```

## Collection

An array-like or a hash-like object that can be iterated over using the `each` method as usual. Individual elements may be accessed with the `[]` notation. Other methods provided by the [Enumerable](https://ruby-doc.org/core-2.4.1/Enumerable.html) module are available as well, except for `to_a` and `to_h` which have some caveats (check the [Objects' attributes and raw objects](#objects-attributes-and-raw-objects) to learn more). Some collections may also have additional methods, like `tournament_id` or `season_id`.

So, for example, `Players` is a collection that contains a bunch of `Player` models. `Teams` is also a collection, whereas `Team` is a model. Note, that sometimes models inside a collection may lack some information:

```ruby
players = client.players
players.first.comment # Returns `nil` as information is not provided by the API
```

Unfortunately, this is how API works. Still, there is a workaround to this problem: [eager loading](https://github.com/bodrovis/ChgkRating/wiki/Lazy-and-eager-loading#eager-loading).

## Objects' attributes and raw objects

One important thing to note is that resources attributes' names (and, consequently, getter methods) are not always the same as the ones returned by ChgkAPI. This is because many attributes returned by the API have too tedious names, like `idteam` or `idtournament`. We already now that's a tournament, so why do we want to say `tournament.idtournament` and not just `tournament.id`? Full list of attributes can be found at the [Usage section](https://github.com/bodrovis/ChgkRating#usage).

However, you might want to **convert** an object back to its original raw form, identical to the one returned by the API. This is possible too! For example, if you have a `Team` model, you may easily convert it to a raw form by using `#to_h` method. The following guidelines apply:

* Models can *only* be converted to hashes using `#to_h`.
* Most collections can *only* be converted to arrays using `#to_a` method. Note that underlying models are converted to hashes. So, if you have a `Teams` collection with a bunch of `Team` models inside, you'll get an array of hashes after calling `#to_a`.
* Some collections (like, for example, list of tournaments grouped by season played by a specific team) can be converted to hashes only using `#to_h`. Such collections do not respond to `#to_a` method. Check documentation for a specific resource to learn whether it responds to `#to_h` or `#to_a`.