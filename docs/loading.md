# Lazy and Eager Loading

## Lazy Loading

Some models can be lazily loaded by providing the `lazy: true` option. For example, you can lazy load a team with an id of `1`:

```ruby
team = client.team 1, true
```

In this case the model will be instantiated only with an id and **the request will not be sent to the API**. So basically you are instantiating a `Team` class without performing a GET request at all. Why is this needed? Well, some models (like `Team`) have a bunch of interface methods that you may utilize. For example, you can say:

```ruby
team.ratings
```

to get all ratings for a lazily loaded team. However, in order to load a rating for a team, you don't really need to load information about the team itself. So, basically we are reducing the number of GET requests.

Note that some resources are being lazily loaded automatically - that's how API works. Suppose we want to get recap (roster) for a team with an id of `1` at season `9`:

```ruby
client.recap 1, 9
``` 

API will return only the players' ids, not their full information. So, in this case we are also loading the `Player` models lazily (they are nested inside the `Recap` model).

If a model supports lazy loading, it will have a `@lazy` attribute and and `lazy` reader. If it does not support lazy loading, the `lazy` reader will not be defined and `NO_LAZY_SUPPORT` will be set to `true`.

Some collections may also accept a `lazy` option - this will mark all models of a collection as lazily loaded, though in most cases this makes little sense as API request will still be sent (check docs for a specific method to learn more):

```ruby
client.players lazy: true
```

## Eager Loading

If there is lazy loading, there should be also eager loading, right? If a model supports eager loading, you can load full information via API like this:

```ruby
player = client.player 1, true # lazily load a player with an id of 1
player.eager_load! # load full information about the player from the API 
```

So, in this example we are firstly loading the player lazily and then perform eager loading. After eager loading finishes, the `@lazy` attribute is set to `false` and subsequent calls to `eager_load!` will have no effect.

Still, if you want to reload the data for some model, set the `force` argument to `true`:

```ruby
player.eager_load! true
```

This will forcibly load information about the player again.

Eager loading can come in handy when a model is lazy-loaded automatically. Recall the example from the previous section:

```ruby
recap = client.recap 1, 9
players = recap.players # A collection of lazily loaded Player models
``` 

So, in this example `Player` models are lazily-loaded because the API returns only the players' ids, nothing more. But suppose you'd like to get more detailed information about a specific player. This is possible with the `eager_load!` method:

```ruby
players[3].eager_load!
```

An API request will be performed and information about the player will be loaded for you!

Also it is possible to eager-load all elements of a collection:

```ruby
players.map &:eager_load!
```

Note however that in some cases this may result in **lots** of API requests so be careful.