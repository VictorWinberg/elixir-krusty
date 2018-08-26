defmodule Krusty.CookieView do
  use Krusty.Web, :view

  def render("index.json", %{cookies: cookies}) do
    %{data: render_many(cookies, Krusty.CookieView, "cookie.json")}
  end

  def render("show.json", %{cookie: cookie}) do
    %{data: render_one(cookie, Krusty.CookieView, "cookie.json")}
  end

  def render("cookie.json", %{cookie: cookie}) do
    %{
      id: cookie.id,
      name: cookie.name
    }
    |> append_ingredients(cookie.ingredients)
    |> append_orders(cookie.orders)
  end

  def render("ingredient.json", %{ingredient: ingredient}) do
    %{
      id: ingredient.id,
      amount: ingredient.amount,
      ingredient_id: ingredient.ingredient_id
    }
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      amount: order.amount,
      order_id: order.order_id
    }
  end

  defp append_ingredients(data, ingredients) do
    if Ecto.assoc_loaded?(ingredients) do
      ingredients = render_many(ingredients, Krusty.CookieView, "ingredient.json", as: :ingredient)
      Map.put(data, :ingredients, ingredients)
    else
      data
    end
  end

  defp append_orders(data, orders) do
    if Ecto.assoc_loaded?(orders) do
      orders = render_many(orders, Krusty.CookieView, "order.json", as: :order)
      Map.put(data, :orders, orders)
    else
      data
    end
  end
end
