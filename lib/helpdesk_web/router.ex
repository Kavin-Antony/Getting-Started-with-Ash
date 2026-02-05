defmodule HelpdeskWeb.Router do
  use HelpdeskWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HelpdeskWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelpdeskWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/tickets", TicketLive.Index
  end
end
