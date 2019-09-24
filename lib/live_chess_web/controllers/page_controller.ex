defmodule LiveChessWeb.PageController do
  use LiveChessWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
