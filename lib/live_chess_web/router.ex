defmodule LiveChessWeb.Router do
  use LiveChessWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveChessWeb do
    pipe_through :browser

    get "/", MatchController, :index
    get "/new", MatchController, :new
    get "/play", MatchController, :play, as: :match_play
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveChessWeb do
  #   pipe_through :api
  # end
end
