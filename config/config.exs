# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :krusty,
  ecto_repos: [Krusty.Repo]

# Configures the endpoint
config :krusty, Krusty.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pOTNv19Zj3FJqGfdAuoZAnZODOV0/1ZnqJ3gHYQEAzBgU9vi7d8bChvM//V0E131",
  render_errors: [view: Krusty.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Krusty.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
