# Krusty

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Tutorial

Setup project:

  * Create a new project with `mix phoenix.new krusty`
  * Go into your application with `cd krusty`
  * Check if dev config is correct `vim config/dev.exs`
  * Then create database with `mix ecto.create`
  * Start your app with `mix phx.server`

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

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
