# Команды на турнире

## Коллекция

Возвращает объект `TournamentTeams`, созданный на основе массива и содержащий в себе команды, участвовавшие в заданном турнире. Он содержит в себе модели `TournamentTeam`.

```ruby
client.teams_at_tournament tournament_or_id  # Входные значения:
                                             # tournament_id - Integer, String или Tournament
```

Коллекция отвечает на следующие методы:

```ruby
tournament # Tournament ("лениво" загруженная модель)
```

## Модель

Возвращает образец класса `TournamentTeam`.

```ruby
client.team_at_tournament tournament_or_id, team_or_id # Входные значения:
                                                       # tournament_or_id - Integer, String или Tournament
                                                       # team_or_id -  Integer, String или Team
```

Обратите внимание, что этот метод **всегда** возвращает "лениво" загруженную модель, которую нельзя принудительно загрузить с помощью метода `#eager_load!`, так как API не позволяет получать данные об одной команде на турнире. Поэтому для модели, загруженной таким образом, установлены только следующие атрибуты:

```ruby
id              # String 
tournament      # Tournament ("лениво" загруженная модель)
```

Модель, загруженная с помощью метода `#team_at_tournament`, может быть использована для вызова вспомогательных методов, указанных ниже.

Модели, входящие в коллекцию `TournamentTeams` (которая была загружена с помощью метода `#teams_at_tournament`, описанного выше), отвечают на следующие методы:

```ruby
id                  # String
current_name        # String
base_name           # String
position            # Float
questions_total     # Integer
result              # Array - содержит логические значения, каждое из которых указывает, ответила ли команда на вопрос.
                    # Длина массива соответствует значению, возвращаемому методом questions_total
bonus_a             # Integer
bonus_b             # Integer
tech_rating         # Integer
predicted_position  # Integer
real_bonus_b        # Integer
d_bonus_b           # Integer
included_in_rating  # Boolean
```

### Вспомогательные методы

Модель `TournamentTeam` имеет следующие вспомогательные методы:

```ruby
tournament_team.players # Возвращает коллекцию TournamentPlayers, созданную на основе массива, которая содержит состав команды на текущем турнире

tournament_team.results # Возвращает коллекцию TournamentTeamResults, созданную на основе массива, которая содержит результат команды на текущем турнире
```