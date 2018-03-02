# Getting Started

This gem works **only** with Ruby 2.4+ and I have no plans of making it compatible with older versions. Apart from that, it has no special requirements.

Install it by running:

    $ gem install chgk_rating
    
## Initializing the Client

Initialize the client with the following shortcut:

```ruby
client = ChgkRating.client
```

This method does not accept any arguments because the client requires no configuration. You don't need any API keys, access tokens and that stuff - just go ahead and send any queries you like. Seems like the API has no quota limitation as well but of course it does not mean you should abuse it.

Now you may utilize the `client` local variable to perform various requests.
    
## Additional Info

As long as this gem is not just a wrapper, there are a bunch of things that you might want to know before starting to use it. This information, however, is optional and if you just want to quickly fetch some info about a specific resource, ignore it.

* [Types of resources](/resources) - explains what are models and collections are in terms of this gem and how to convert resources back to their raw form
* [Pagination](/pagination) 
* [Lazy and eager loading](/loading) - explains why you might not see full information about some resource and how to forcibly load it