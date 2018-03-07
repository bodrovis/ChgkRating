# Составы команды на турнире

## Коллекция

Возвращает объект `TournamentPlayers`, созданный на основе массива. Он содержит в себе модели `TournamentPlayer`, каждая из которых хранит информацию об отдельном игроке.

```ruby
client.team_players_at_tournament tournament_or_id, team_or_id  # Input:
                                                                # tournament_or_id - Integer, String or Tournament
                                                                # team_or_id -  Integer, String or Team
```

Коллекция отвечает на следующие методы:

```ruby
id              # String
tournament      # Tournament ("лениво" загруженная модель)
```

## Модель

Прямая загрузка информации об одном игроке на турнире невозможна, поэтому для получения информации о конкретном человеке необходимо сначала загрузить весь состав с помощью метода `#team_players_at_tournament`, описанного выше, а затем обратиться к нужному элементу массива с помощью `[]`.

Обратите внимание, что `TournamentPlayer` — это **совершенно другая модель**, которая отличается от модели `Player` и содержит другие атрибуты. Однако, идентификаторы игрока, конечно, будут совпадать.

Доступные методы:

```ruby
id          # String
is_captain  # Boolean
is_base     # Boolean
is_foreign  # Boolean
```