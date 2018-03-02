# Pagination

Some resources are paginated by the ChgkRating API. The number of items per page always equals to `1000` and there is no way to change this. By default you get the first page but, of course, it is possible to request another page by providing the `:page` option. For example, get the second page of the "players" resource:

```ruby
client.players page: 2
```

Check docs for a specific method to learn whether it supports pagination.