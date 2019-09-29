defmodule LiveChessWeb.MatchController do
  use LiveChessWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.match_path(conn, :new))
  end

  def new(conn, _params) do
    pid = get_session(conn, :game_pid)
    if Process.alive?(pid), do: Chex.end_game(pid)

    {:ok, pid} = Chex.new_game()

    conn =
      conn
      |> put_session(:game_pid, pid)

    redirect(conn, to: Routes.match_path(conn, :play))
  end

  def play(conn, _params) do
    pid = get_session(conn, :game_pid)

    unless Process.alive?(pid) do
      {:ok, pid} = Chex.new_game()
    end

    live_render(conn, LiveChess.ChessMatchLive, session: %{game_pid: pid})
  end
end
