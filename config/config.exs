# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :live_chess, LiveChessWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wTDOs0dRqa7O/FkCbxtNLLOnT81QysZ2Gj4y0kRu4phx/A+HsDnSH0Xr0pFM6Gb8",
  render_errors: [view: LiveChessWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveChess.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "7/Mu2AoNY4Lhj8OZFBW1Qslfzw2LI29W"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
