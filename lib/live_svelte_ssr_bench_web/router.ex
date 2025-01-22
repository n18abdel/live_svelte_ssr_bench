defmodule LiveSvelteSsrBenchWeb.Router do
  use LiveSvelteSsrBenchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveSvelteSsrBenchWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveSvelteSsrBenchWeb do
    pipe_through :browser

    live "/", NumbersLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveSvelteSsrBenchWeb do
  #   pipe_through :api
  # end
end
