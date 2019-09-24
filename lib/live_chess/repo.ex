defmodule LiveChess.Repo do
  use Ecto.Repo,
    otp_app: :live_chess,
    adapter: Ecto.Adapters.Postgres
end
