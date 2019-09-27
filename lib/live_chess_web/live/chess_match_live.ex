defmodule LiveChess.ChessMatchLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveChessWeb.GameView, "match.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, pid} = Chex.new_game()
    game = Chex.state(pid)
    socket = update_assigns_from_game(socket, game)
    if connected?(socket), do: Chex.Server.subscribe(pid, self())
    {:ok, assign(socket, pid: pid, selected_square: nil)}
  end

  def handle_event("square-clicked", %{"name" => n}, %{assigns: %{selected_square: n}} = socket) do
    {:noreply, assign(socket, selected_square: nil)}
  end

  def handle_event("square-clicked", %{"name" => n}, %{assigns: %{selected_square: nil}} = socket) do
    {:noreply, assign(socket, selected_square: n)}
  end

  def handle_event(
        "square-clicked",
        %{"name" => to},
        %{assigns: %{selected_square: from, pid: pid}} = socket
      ) do
    case Chex.move(pid, from <> to) do
      {:error, _reason} ->
        {:noreply, assign(socket, selected_square: nil)}

      game ->
        # Ask computer to move
        GenServer.cast(pid, :engine_move)
        socket = assign_pieces(socket, game)
        {:noreply, assign(socket, selected_square: nil)}
    end
  end

  def handle_info(%Chex.Game{} = game, socket) do
    {:noreply, update_assigns_from_game(socket, game)}
  end

  def update_assigns_from_game(socket, game) do
    socket
    |> assign_pieces(game)
    |> assign_to_move(game)
    |> assign_moves(game)
    |> assign_black_captures(game)
    |> assign_white_captures(game)
  end

  def assign_pieces(socket, game) do
    p =
      game
      |> Map.get(:board)
      |> Map.from_struct()
      |> Enum.reject(fn {_k, v} -> is_nil(v) end)
      |> Enum.map(fn {current_sq, {name, color, {sf, sr}}} ->
        {"#{sf}#{sr}", {name, color, current_sq}}
      end)
      |> Enum.sort()

    assign(socket, pieces: p)
  end

  def assign_to_move(socket, game) do
    assign(socket, to_move: Map.get(game, :active_color))
  end

  def assign_moves(socket, game) do
    assign(socket, moves: Map.get(game, :moves))
  end

  def assign_black_captures(socket, game) do
    captures =
      game
      |> Map.get(:captures)
      |> Enum.filter(fn {_name, color, _sq} -> color == :black end)

    assign(socket, black_captures: captures)
  end

  def assign_white_captures(socket, game) do
    captures =
      game
      |> Map.get(:captures)
      |> Enum.filter(fn {_name, color, _sq} -> color == :white end)

    assign(socket, white_captures: captures)
  end
end
