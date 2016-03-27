-module(cowboy_routes_tree).

%% API exports

-export([rt/1]).

%% Types. partially stolen from cowboy router
-type route_match() :: '_' | iodata().
-type route() :: {Path::route_match(), Handler::module(), Opts::any()}
                    | {Path::route_match(), cowboy:fields(), Handler::module(), Opts::any()}.
-type simple_routes() :: [route()].
-type routes_with_prefix() :: {iodata(), simple_routes()}.
-type routes() :: [route() | routes_with_prefix()].

%%====================================================================
%% API functions
%%====================================================================

-spec rt(routes()) -> simple_routes().
rt(Routes) ->
  lists:flatten([process_route(Route) || Route <- Routes]).

%%====================================================================
%% Internal functions
%%====================================================================

-spec add_prefix_to_route(iodata(), route()) -> route().
add_prefix_to_route(Prefix, {Path, Handler, Opts}) ->
  {iolist_to_binary([Prefix, Path]), Handler, Opts};
add_prefix_to_route(Prefix, {Path, Fields, Handler, Opts}) ->
  {iolist_to_binary([Prefix, Path]), Fields, Handler, Opts}.

-spec process_route(route() | routes_with_prefix ()) -> simple_routes().
process_route({Prefix, Routes}) ->
  {PrefixPath, PRoute} = case Prefix of
                           {PPath, _, _} -> {PPath, Prefix};
                           {PPath, _, _, _} -> {PPath, Prefix};
                           _ -> {Prefix, []}
                         end,
  [PRoute, [add_prefix_to_route(PrefixPath, Route) || Route <- rt(Routes)]];
process_route(Route) ->
  Route.
