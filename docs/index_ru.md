---
layout: default
---

Добро пожаловать! **ChgkRating** — это клиент, написанный на языке [Ruby](http://ruby-lang.org/), который значительно упрощает работу с API сервиса [rating.chgk.info](http://rating.chgk.info/index.php/api) и позволяет работать с возвращаемыми данными как с обычными объектами Ruby.

Сервис [rating.chgk.info](http://rating.chgk.info/index.php/api) предоставляет официальную статистику [спортивной версии игры "Что? Где? Когда?"](https://ru.wikipedia.org/wiki/%D0%A7%D1%82%D0%BE%3F_%D0%93%D0%B4%D0%B5%3F_%D0%9A%D0%BE%D0%B3%D0%B4%D0%B0%3F_(%D1%81%D0%BF%D0%BE%D1%80%D1%82%D0%B8%D0%B2%D0%BD%D0%B0%D1%8F_%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%8F)). Обратите внимание, что ChgkRating — сторонняя библиотека, автор которой не имеет отношения к сервису rating.chgk.info и МАК ЧГК.

Подробную документацию по каждому из поддерживаемых ресурсов вы можете найти в меню справа. Сообщить об ошибке, задать вопрос или запросить новый функционал можно в [баг-трекере GitHub](https://github.com/bodrovis/ChgkRating/issues).

## Небольшой пример использования

```ruby
# Инстанцируем клиент:
client = ChgkRating.client

# Получаем информацию обо всех игроках (первые 1000 записей):
client.players 

# Получаем информацию о желаемой команде:
team = client.team 1 

# Получаем информацию об этой команде на турнире с указанным идентификатором:
team.at_tournament 1000 

# Получаем результаты для этой команды (кол-во взятых вопросов и т.п.):
team.at_tournament(1000).results

# Эта же информация может быть получена и другим способом: 
client.team_results_at_tournament 1000, team

# Можно также загрузить нужный турнир...
tournament = client.tournament 1000

# ...а затем посмотреть, как команда на нём сыграла таким способом:
team.at_tournament(tournament).results
# или таким:
client.team_results_at_tournament tournament, team
```