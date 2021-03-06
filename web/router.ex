defmodule Krusty.Router do
  use Krusty.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Krusty do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Krusty do
    pipe_through :api

    resources "/cookies", CookieController do
      resources "/ingredients", CookieIngredientController, only: [:create, :index]
      resources "/orders", CookieOrderController, only: [:create]
    end

    resources "/ingredients", IngredientController
    resources "/customers", CustomerController

    resources "/orders", OrderController
    resources "/deliveries", DeliveryController
    resources "/pallets", PalletController
  end
end
