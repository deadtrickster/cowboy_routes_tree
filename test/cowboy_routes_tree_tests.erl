-module(cowboy_routes_tree_tests).

-include_lib("eunit/include/eunit.hrl").

success_test () ->
  ?assertEqual(cowboy_routes_tree:rt([{"/v1",
                                       [{{<<"/users">>, users_handler, []},
                                         [{"/:user_id", user_handler, []}]},
                                        {{"/tweets", tweets_handler, []},
                                         [{"/my", my_tweets_handler, []},
                                          {"/:user_id", user_tweets_handler, []}]},
                                        {"/apps",
                                         [{"/:app_id", app_handler, []}]}]},
                                      {"/metrics", metrics_handler, []}]),
               [{<<"/v1/users">>,users_handler,[]},
                {<<"/v1/users/:user_id">>,user_handler,[]},
                {<<"/v1/tweets">>,tweets_handler,[]},
                {<<"/v1/tweets/my">>,my_tweets_handler,[]},
                {<<"/v1/tweets/:user_id">>,user_tweets_handler,[]},
                {<<"/v1/apps/:app_id">>,app_handler,[]},
                {"/metrics",metrics_handler,[]}]).

errpr_test () ->
  ?assertError(function_clause, cowboy_routes_tree:rt([{"/v1",
                                                        [{<<"/users">>,
                                                          [{"", users_handler},
                                                           {"/:user_id", user_handler, []}]}]},
                                                       {"/metrics", metrics_handler, []}])),
  ?assertError(badarg, cowboy_routes_tree:rt([{"/v1",
                                               [{qwe,
                                                 [{"", users_handler, []},
                                                  {"/:user_id", user_handler, []}]}]},
                                              {"/metrics", metrics_handler, []}])).
