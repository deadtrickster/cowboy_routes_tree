cowboy_routes_tree
=====

Organize cowboy routes in trees

Transforms
```erlang
[{"/v1",
  [{{<<"/users">>, users_handler, []},
    [
     {"/:user_id", user_handler, []}
    ]},
   {{"/tweets", tweets_handler, []},
    [
     {"/my", my_tweets_handler, []},
     {"/:user_id", user_tweets_handler, []}
    ]},
   {"/apps",
    [
     {"/:app_id", app_handler, []}
    ]}]},
 {"/metrics", metrics_handler, []}]
```
to
```erlang
[{<<"/v1/users">>,users_handler,[]},
 {<<"/v1/users/:user_id">>,user_handler,[]},
 {<<"/v1/tweets">>,tweets_handler,[]},
 {<<"/v1/tweets/my">>,my_tweets_handler,[]},
 {<<"/v1/tweets/:user_id">>,user_tweets_handler,[]},
 {<<"/v1/apps/:app_id">>,app_handler,[]},
 {"/metrics",metrics_handler,[]}]
```

Build & Test
-----

    $ rebar3 compile
    $ rebar3 eunit

License
-----
BSD 3-Clause
