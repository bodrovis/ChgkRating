# Разбиение по страницам

Некоторые данные, возвращаемые API, разбиты по страницам. На одной странице всегда размещается не более `1000` элементов и на это никак нельзя повлиять. По умолчанию возвращается первая страница, но можно запросить другую страницу с помощью опции `:page`:

```ruby
client.players page: 2 # Вторая страница со списком всех игроков
```

В документации для каждой коллекции указано, поддерживает ли она опцию `:page`.