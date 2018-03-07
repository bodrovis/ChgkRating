# Рейтинги команды

## Коллекция

Возвращает объект `Ratings`, созданный на основе массива и содержащий в себе рейтинги команды. Он содержит в себе модели `Rating`.

```ruby
client.ratings team_or_id # Входные значения:
                          # team_or_id - String, Integer или Team. Команда, для которой требуется загрузить рейтинги
```

Коллекция отвечает на следующие методы:

```ruby
team # Team ("лениво" загруженная модель)
```

## Модель

Возвращает образец класса `Rating`, содержащий информацию о рейтинге команды в заданном релизе.

```ruby
client.rating team_or_id, release_id  # Input:
                                      # team_or_id - String, Integer или Team
                                      # release_id - String или Integer
```

Доступные методы:

```ruby
team            # Team ("лениво" загруженная модель)
release_id      # String
rating          # Integer
rating_position # Integer
date            # Date
formula         # Symbol - :a или :b
```