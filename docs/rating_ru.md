# Рейтинги команды

## Коллекция

Возвращает объект `Ratings`, созданный на основе массива и содержащий в себе рейтинги команды. Он содержит в себе модели `Rating`.

```ruby
client.team_ratings team_or_id # Входные значения:
                               # team_or_id - String, Integer или Team. Команда, для которой требуется загрузить рейтинги
```

Возвращает объект `Ratings`, созданный на основе массива и содержащий в себе рейтинги игрока. Он содержит в себе модели `Rating`.

```ruby
client.player_ratings player_or_id # Входные значения:
                                   # player_or_id - String, Integer или Player. Игрок, для которого требуется загрузить рейтинги
```

Коллекция отвечает на следующие методы:

```ruby
team   # Team ("лениво" загруженная модель)
player # Player ("лениво" загруженная модель)
```

## Модель

Возвращает образец класса `Rating`, содержащий информацию о рейтинге команды в заданном релизе.

```ruby
client.team_rating team_or_id, release_id  # Input:
                                           # team_or_id - String, Integer или Team
                                           # release_id - String или Integer
```

Возвращает образец класса `Rating`, содержащий информацию о рейтинге игрока в заданном релизе.

```ruby
client.player_rating player_or_id, release_id  # Input:
                                               # player_or_id - String, Integer или Player
                                               # release_id - String или Integer
```

Доступные методы:

```ruby
team                    # Team ("лениво" загруженная модель)
player                  # Player ("лениво" загруженная модель)
release_id              # String
rating                  # Integer
rating_position         # Integer
date                    # Date
formula                 # Symbol - :a или :b
tournaments_in_year     # Integer - количество турниров, сыгранных в этом году (только для игрока)
tournament_count_total  # Integer - общее количество сыгранных турниров (только для игрока)
```