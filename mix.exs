defmodule TwitchApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :twitch_api,
      version: "0.1.0",
      elixir: "~> 1.11",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      # Docs
      name: "TwitchApi",
      source_url: "https://github.com/kamiyuzu/twitch_api",
      docs: [
        main: TwitchApi,
        logo: "lib/assets/twitch_logo.svg.png",
        extras: ["README.md"],
        groups_for_modules: ex_docs_groups()
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {TwitchApi.Application, []},
      extra_applications: [:logger, :iex, :cowboy, :plug]
    ]
  end

  defp description do
    "Elixir Twitch API framework"
  end

  defp package do
    [
      maintainers: ["Alberto Revuelta / Kamiyuzu"],
      licenses: ["GPL-3.0-or-later"],
      links: %{"GitHub" => "https://github.com/kamiyuzu/twitch_api"},
      files: ~w(lib mix.exs README* LICENSE)
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2.2"},
      {:ecto, "~> 3.7.0"},
      {:finch, "~> 0.8"},
      {:cowboy, "~> 2.9.0"},
      {:plug_cowboy, "~> 2.5.2"},
      {:plug, "~> 1.12.1"},
      {:uuid, "~> 1.1"}
    ] ++ dev_deps() ++ test_deps()
  end

  defp dev_deps do
    [
      {:dialyxir, "~> 1.1.0", only: :dev, runtime: false},
      {:credo, "~> 1.5.6", only: [:dev, :test], runtime: false},
      {:inch_ex, "~> 0.5.6", only: :dev},
      {:ex_doc, "~> 0.25", only: :dev}
    ]
  end

  defp test_deps do
    [
      {:mock, "~> 0.3.7", only: :test, runtime: false},
      {:excoveralls, "~> 0.14.2", only: :test}
    ]
  end

  defp ex_docs_groups() do
    [
      "Twitch api template": [
        TwitchApi.ApiJson.Template
      ],
      "Twitch api module doc template": [
        TwitchApi.ApiJson.Template.ModuleDoc
      ],
      "Twitch api module name template": [
        TwitchApi.ApiJson.Template.ModuleName
      ],
      "Twitch api doc template": [
        TwitchApi.ApiJson.Template.Doc
      ],
      "Twitch api alias template": [
        TwitchApi.ApiJson.Template.Alias
      ],
      "Twitch api method template": [
        TwitchApi.ApiJson.Template.Method,
        TwitchApi.ApiJson.Template.Method.Url,
        TwitchApi.ApiJson.Template.Method.Headers,
        TwitchApi.ApiJson.Template.Method.BodyParams,
        TwitchApi.ApiJson.Template.Method.Args,
        TwitchApi.ApiJson.Template.Method.Args.Authentication,
        TwitchApi.ApiJson.Template.Method.Args.Authorization,
        TwitchApi.ApiJson.Template.Method.Args.Params.Body,
        TwitchApi.ApiJson.Template.Method.Args.Params.Query
      ],
      "Twitch api adapter": [
        TwitchApi.MyFinch
      ],
      "Twitch api json item": [
        TwitchApi.ApiJson.Item
      ],
      "Twitch api json doc item": [
        TwitchApi.ApiJson.Item.Doc,
        TwitchApi.ApiJson.Item.Doc.Request,
        TwitchApi.ApiJson.Item.Doc.Response
      ],
      "Twitch api json request item": [
        TwitchApi.ApiJson.Item.Request,
        TwitchApi.ApiJson.Item.Request.Field,
        TwitchApi.ApiJson.Item.Request.Param,
        TwitchApi.ApiJson.Item.Request.ResponseCode,
        TwitchApi.ApiJson.Item.Request.Url
      ],
      "Twitch api json category item": [
        TwitchApi.ApiJson.Item.Category
      ],
      "Twitch api json filesystem": [
        TwitchApi.ApiJson.FileSystem
      ]
    ]
  end
end
