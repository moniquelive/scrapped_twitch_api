# TwitchApi

[![CI](https://github.com/kamiyuzu/scrapped_twitch_api/actions/workflows/elixir_cd.yml/badge.svg)](https://github.com/kamiyuzu/twitch_api_scraper/actions/workflows/elixir_cd.yml/badge.svg)
[![CI](https://github.com/kamiyuzu/scrapped_twitch_api/actions/workflows/elixir_ci.yml/badge.svg)](https://github.com/kamiyuzu/twitch_api_scraper/actions/workflows/elixir_ci.yml/badge.svg)
![GitHub](https://img.shields.io/github/license/kamiyuzu/twitch_api_scraper)
[![Hexdocs.pm](https://img.shields.io/badge/hexdocs-online-blue)](https://hexdocs.pm/scrapped_twitch_api/)
[![Hex.pm](https://img.shields.io/hexpm/v/scrapped_twitch_api.svg)](https://hex.pm/packages/scrapped_twitch_api)
<!--- [![Hex.pm Downloads](https://img.shields.io/hexpm/dt/scrapped_twitch_api)](https://hex.pm/packages/scrapped_twitch_api) -->

This library provides an Elixir library for twitch API. It makes use of an Elixir scrapper for [Twitch API](https://github.com/kamiyuzu/twitch_api_scraper).

## Library configuration

For making use of this library you will need to create a `.env` with the env vars from the `.env_example`. The env vars needed have to be fetched from [twitch developer documentation](https://dev.twitch.tv/docs/api).

In the [.env](.env) file environment vars needs to be defined for usage. Those need to be loaded when working with this project. To do so, one can manually execute:

```bash
source .env
```

or automate this process using [direnv](https://direnv.net/).

```bash
# Install direnv using brew
$ brew install direnv

# From the project folder
$ direnv allow
```

Continue with the instructions [here](https://github.com/direnv/direnv#setup)

## Library usage

The library provides dynamically modules for fetching all Twitch API endpoints. The convention is: `TwitchApi.<TwitchCategory>.<Action><Endpoint>`. The convention might not be a rule since Twitch reference do not follow this rule always.

This is an example running iex:

```elixir
iex(1)> alias TwitchApi.Users.GetUsers
TwitchApi.Users.GetUsers
iex(2)> GetUsers.call(%{login: "hiimkamiyuzu"})
{:ok,
 %Finch.Response{
   body: "{\"data\":[{\"id\":\"61425548\",\"login\":\"hiimkamiyuzu\",\"display_name\":\"hiimkamiyuzu\",\"type\":\"\",\"broadcaster_type\":\"\",\"description\":\"\",\"profile_image_url\":\"https://static-cdn.jtvnw.net/user-default-pictures-uv/294c98b5-e34d-42cd-a8f0-140b72fba9b0-profile_image-300x300.png\",\"offline_image_url\":\"\",\"view_count\":56,\"created_at\":\"2014-04-22T20:21:11Z\"}]}",
   headers: [
     {"connection", "keep-alive"},
     {"content-length", "344"},
     {"content-type", "application/json; charset=utf-8"},
     {"access-control-allow-origin", "*"},
     {"ratelimit-limit", "800"},
     {"ratelimit-remaining", "799"},
     {"ratelimit-reset", "1632430212"},
     {"timing-allow-origin", "https://www.twitch.tv"},
     {"twitch-trace-id", "3b9411d4cc5dcd10b82d2f839a5cecfd"},
     {"x-ctxlog-logid", "1-614ce883-61e26c085d4f987c0eb6b429"},
     {"date", "Thu, 23 Sep 2021 20:50:11 GMT"},
     {"x-served-by", "cache-sea4481-SEA, cache-mad22034-MAD"},
     {"x-cache", "MISS, MISS"},
     {"x-cache-hits", "0, 0"},
     {"x-timer", "S1632430212.605339,VS0,VS0,VE180"},
     {"vary", "Accept-Encoding"},
     {"strict-transport-security", "max-age=300"}
   ],
   status: 200
 }}
iex(3)> h GetUsers.call/1

                                 def call(map)                                  

  @spec call(id() | login()) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}

### Description:

Gets information about one or more specified Twitch users. Users are identified
by optional user IDs and/or login name.

### Required authentication:

OAuth or App Access Token required.
iex(4)> t GetUsers.id
@type id() :: %{id: String.t()}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `scrapped_twitch_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:scrapped_twitch_api, "~> 0.1.0"}
  ]
end
```

Docs can be found at [https://hexdocs.pm/scrapped_twitch_api](https://hexdocs.pm/scrapped_twitch_api).

