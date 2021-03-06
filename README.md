# Krusty

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Table of Contents

* [Tips](#tips)
* [Tutorial](#tutorial)
  + [TL:DR](#tldr)
  + [Setup](#setup)
  + [Independent resources](#independent-resources)
  + [Semi-independent resources](#semi-independent-resources)
    - [- Models](#--models)
    - [- Controllers](#--controllers)
    - [- Views](#--views)
    - [- Router](#--router)
    - [- Migrate](#--migrate)
  + [Dependent resources](#dependent-resources)
    - [- Models](#--models-1)
    - [- Controllers](#--controllers-1)
    - [- Views](#--views-1)
    - [- Router](#--router-1)
    - [- Migrate](#--migrate-1)
* [Learn more](#learn-more)

## Tips

  * Use [Ecto cheatsheet](https://devhints.io/phoenix-ecto)
  * Use Elixir Repl:
    * Elixir Repl with mix: `iex -S mix`
    * Import Ecto Query: `import Ecto.Query`
    * Create aliases: `alias Krusty.{Repo, Cookie, ...}`
  * Play around with Elixir Repl!

## Tutorial

### TL:DR

TL:DR - Version

  * Setup `mix phoenix.new krusty`
  * Generate JSON resource or model: `mix phoenix.gen.json Cookie cookies name:string`
  * Models - Update
    * Associate parents with `has_many :cookies, Krusty.Cookie`
    * Update params in `cast` and `validate_required`
    * Create Query methods with `from model in query`, `select`, ...
  * Controllers - Add/Update
    * Load associations with `Repo.preload` or `Cookie.query`
    * Build associations with `Ecto.build_assoc`
    * Create model changeset with `Cookie.changeset`
  * Views - Add/Update
    * Check has loaded associations with `Ecto.assoc_loaded?`
    * Append key-value pair on map with `Map.put`
  * Router - Update
    * Add resources to api-scope
  * Migrate

### Setup

Setup project

  * Create a new project with `mix phoenix.new krusty`
  * Go into your application with `cd krusty`
  * Check if dev config is correct `vim config/dev.exs`
  * Then create database with `mix ecto.create`
  * Start your app with `mix phoenix.server`

### Independent resources

Generate JSON resources:

  * Cookie resource with `mix phoenix.gen.json Cookie cookies name:string`
  * Ingredient resource with `mix phoenix.gen.json Ingredient ingredients name:string`
  * Customer resource with `mix phoenix.gen.json Customer customers name:string address:string`

Add the resources to the api scope in `web/router.ex`:

```
scope "/api", Krusty do
  pipe_through :api

  resources "/cookies", CookieController
  resources "/ingredients", IngredientController
  resources "/customers", CustomerController
end
```

Migrate: `mix ecto.migrate`

### Semi-independent resources

Generate JSON resources with references:

  * Generate Order with `mix phoenix.gen.json Order orders date:date status:integer customer_id:references:customers`
  * Generate Delivery with `mix phoenix.gen.json Delivery deliveries amount:integer date:date ingredient_id:references:ingredients`
  * Generate Pallet with `mix phoenix.gen.json Pallet pallets label:string date:date status:integer cookie_id:references:cookies order_id:references:orders`

#### - Models

Add model associations for resources with references:

  * Associate Customer with Order: `has_many :orders, Krusty.Order` in `web/models/customer.ex`
  * Associate Ingredient with Delivery: `has_many :deliveries, Krusty.Delivery` in `web/models/ingredient.ex`
  * Associate Cookie and Order with Pallet: `has_many :pallets, Krusty.Pallet` in `web/models/cookie.ex` and `web/models/order.ex`

Update model attributes in changeset in `cast` and `validate_required`:
```
|> cast(params, [..., :parent_id])
|> validate_required([..., :parent_id])
```

#### - Controllers

Add preload methods for some parent controllers:
```
model = Model
        |> Repo.get(id)
        |> Repo.preload(:others)
```

#### - Views

Update render methods for some views:
```
data = %{id: model.id, ...}

if Ecto.assoc_loaded?(model.others) do
  others = render_many(model.others, Krusty.OtherView, "other.json")
  Map.put(data, :others, others)
else
  data
end
```

#### - Router

Add the resources to the api scope in `web/router.ex`:
```
scope "/api", Krusty do
  ...

  resources "/orders", OrderController
  resources "/deliveries", DeliveryController
  resources "/pallets", PalletController
end
```

#### - Migrate: 

Migrate: `mix ecto.migrate`

### Dependent resources

Generate Ecto models with references:

  * Generate CookieIngredient with `mix phoenix.gen.model CookieIngredient cookie_ingredients amount:integer cookie_id:references:cookies ingredient_id:references:ingredients`
  * Generate CookieOrder with `mix phoenix.gen.model CookieOrder cookie_orders amount:integer cookie_id:references:cookies order_id:references:orders`

#### - Models

Add model has_many associations for weak models:

  * Associate Cookie with Ingredient: `has_many :ingredients, Krusty.CookieIngredient` in `web/models/cookie.ex`
  * Associate Cookie with Order: `has_many :orders, Krusty.CookieOrder` in `web/models/cookie.ex`

Update model attributes in changeset in `cast` and `validate_required`:
```
|> cast(params, [..., :parent_id])
|> validate_required([..., :parent_id])
```

Create model query methods:
```
def get(query) do
  from(
    model in query,
    left_join: other in assoc(model, :others),
    group_by: model.id,
    select: %{id: model.id, name: model.name}
  )
end
```

#### - Controllers

Add controllers for weak model:

  * CookieIngredient controller `web/controllers/cookie_ingredient_controller.ex`
  * CookieOrder controller: `web/controllers/cookie_order_controller.ex`

```
defmodule Krusty.CookieChildController do
  use Krusty.Web, :controller

  alias Krusty.{Cookie, CookieChild}

  def create(conn, %{"child" => child_params, "cookie_id" => cookie_id}) do
    cookie = Repo.get(Cookie, cookie_id)
    changeset = cookie
                |> Ecto.build_assoc(:children)
                |> CookieChild.changeset(child_params)

    case Repo.insert(changeset) do
      {:ok, child} ->
        conn
        |> redirect(to: cookie_path(conn, :show, cookie))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
```

Add preload methods for parent controller:
```
model = Model
        |> Repo.get(id)
        |> Repo.preload(:others)
```

Or use the model's query methods:
```
model = Model
        |> Model.query()
        |> Repo.get(id)
```

#### - Views

Update render methods for parent view:
```
data = %{id: model.id, ...}

if Ecto.assoc_loaded?(model.others) do
  others = render_many(model.others, Krusty.OtherView, "other.json")
  Map.put(data, :others, ingredient)
else
  data
end
```

#### - Router

Add the resources to the api scope in `web/router.ex`:
```
scope "/api", Krusty do
  resources "/cookies", CookieController do
    resources "/ingredients", CookieIngredientController
    resources "/orders", CookieOrderController
  end
  ...
end
```

#### - Migrate: 

Migrate: `mix ecto.migrate`

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
