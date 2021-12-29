# Changelog

## v2.1.0 (2021-12-29)

* Updated API mappings (thanks, @L-Eugene)

## v2.0.0 (2021-12-28)

Breaking changes:

* `client.rating` is now `client.team_rating`
* `client.ratings` is now `client.team_ratings`
* `tournament.team` is now `tournament.team_by`

New features:

* Faraday now follows redirects (thanks, @L-Eugene)
* Added ability to fetch ratings for players using `#player_rating` and `#player_ratings`
* `Player` now also responds to `#rating`, `#ratings`, `#tournaments` methods
*  Added ability to fetch tournaments for a player. `#tournaments` now also accepts `player_or_id`.

Testing:   

* Tested against more recent Ruby versions

## v1.0.0 (2018-02-23)

* First stable version at last
* Make `TournamentTeam` compatible with the recent API changes
* More doc tweaks
* Fix tests compatibility with Ruby 2.5

## v1.0.0.rc1 (2018-02-22)

* Collections can be converted to arrays or hashes
* Finished with the docs
* Other tweaks and updates

## v1.0.0.pre2 (2018-01-10)

* Major re-write
* New features (like converting models to hashes)

## v1.0.0.pre1 (2017-10-09)

* Initial release
* Docs are half-finished