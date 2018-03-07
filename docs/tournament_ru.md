# Турниры

## Коллекция

```ruby
client.tournaments team_or_id: nil, season_id: nil, params: {} # Входные значения (аргументы передаются в виде хэша):
                                                               # (необязательное) team_or_id - String, Integer или Team
                                                               # (необязательное) season_id - String или Integer
                                                               # (необязательное) params - Hash
                                                               ## Поддерживаемые параметры:
                                                               ## :page - String или Integer. По умолчанию 1
```

**Если параметры `team_or_id` и `season_id` не установлены**, возвращает коллекцию `Tournaments`, созданную на основе массива, которая содержит все турниры. Коллекция содержит модели `Tournament`, которые содержат только следующие атрибуты:

```ruby
id          # String
name        # String
date_start  # Date
date_end    # Date
type_name   # String
```

**Когда установлен только аргумент `team_or_id`**, возвращает коллекцию `Tournaments`, созданную на основе хэша, где ключами являются номера сезонов, а значениями - модели `Tournament`. Модели "лениво" загружены и, таким образом, имеют только атрибут `id`.

**Когда установлены аргументы `team` и `season_id`**, возвращает коллекцию `Tournaments`, созданную на основе массива, содержащую "лениво" загруженные модели `Tournament`.

Коллекция отвечает на следующие методы:

```ruby
team        # Nil или Team ("лениво" загруженная модель)
season_id   # Nil или String
```

## Модель

Возвращает образец класса `Tournament`, содержащий информацию об одном турнире.

```ruby
client.tournament id, lazy=false  # Входные значения:
                                  # id - Integer или String
                                  # (необязательное) lazy - Boolean
```

Доступные методы:

```ruby
id                        # String
name                      # String
date_start                # DateTime
date_end                  # DateTime
type_name                 # String
town                      # String
long_name                 # String
tour_count                # Integer
tour_questions            # Integer
tour_ques_per_tour        # Integer
questions_total           # Integer
type_name                 # String
main_payment_value        # Float
discounted_payment_value  # Float
discounted_payment_reason # String
date_requests_allowed_to  # DateTime
comment                   # String
site_url                  # URI
```

Особые указания:

* Поддерживается "ленивая" и принудительная загрузка

### Вспомогательные методы

Модель `Tournament` имеет следующие вспомогательные методы:

```ruby
tournament.team_players(team_or_id) # Возвращает коллекцию TournamentPlayers, созданную на основе массива,
                                    # которая содержит состав команды на заданном турнире. Входные значения:
                                    # team_or_id - String, Integer или Team

tournament.team_results(team_or_id) # Возвращает коллекцию TournamentTeamResults, созданную на основе массива,
                                    # которая содержит результаты команды на заданном турнире. Входные значения:
                                    # team_or_id - String, Integer или Team

tournament.team_list                # Возвращает коллекцию TournamentTeams, созданную на основе массива,
                                    # которая содержит список команд, участвовавших в заданном турнире

tournament.team(team_or_id)         # Возвращает модель TournamentTeam, которая содержит информацию о команде на заданном турнире
                                    # team_or_id - String, Integer или Team
```