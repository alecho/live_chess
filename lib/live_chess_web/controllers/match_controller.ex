defmodule LiveChessWeb.MatchController do
  use LiveChessWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.match_path(conn, :new))
  end

  def new(conn, _params) do
    case Chex.new_game() do
      {:ok, pid} ->
        conn
          |> put_session(:game_pid, pid)
          |> redirect(to: Routes.match_path(conn, :play))

      {:error, _error} ->
        put_view(conn, PageView)
        |> render("error.html", message: "Couldn't start a game")
    end
  end

  def play(conn, _params) do
    pid = get_session(conn, :game_pid)

    live_render(conn, LiveChess.ChessMatchLive, session: %{game_pid: pid})
  end
end
