# Начало работы

Обратите внимание, что данная библиотека работает **только** с Ruby версии 2.4 и выше (на данный момент я не планирую внедрять совместимость с более ранними версиями). Никаких других требований у библиотеки нет.

Установка производится в обычном порядке с помощью [RubyGems](http://rubygems.org/):

```bash
$ gem install chgk_rating
```
    
## Инициализация клиента

В первую очередь, необходимо инициализировать клиент следующим образом:

```ruby
client = ChgkRating.client
```

Метод `.client` не принимает никаких аргументов, потому клиент вообще не требует настройки. Для работы с API ЧГК (на данный момент) не нужно генерировать никаких ключей, токенов и прочего - вы можете сразу же начать работу. В документации API также ничего не сказано касательно ограничений по количеству запросов в секунду. Обратите также внимание, что API работает только в режиме чтения и, соответственно, поддерживает только GET-запросы.

После того, как клиент `client` создан, вы можете использовать его для выполнения различных запросов.
    
## Дополнительная информация

Эта библиотека — не просто обёртка для API, и потому в ней присутствует ряд особенностей, о которых, возможно, вам захочется узнать более подробно перед тем, как начать работу. Эта информация, однако, необязательна к изучению: если вам нужно просто получить данные о команде или игроке, то её можно спокойно пропустить.

* [Типы ресурсов](/resources_ru) - что такое модели и коллекции в контексте данной библиотеки, а также как конвертировать объекты в их изначальную форму (обычный хэш или массив)
* [Разбиение по страницам](/pagination_ru)
* ["Ленивая" и полная загрузка](/loading_ru) - почему в некоторых случаях изначально недоступна полная информация о ресурсе, а также как её принудительно загрузить или перезагрузить. Также описывает, как инстанцировать ресурс в "ленивом" режиме, без отправки запроса к API