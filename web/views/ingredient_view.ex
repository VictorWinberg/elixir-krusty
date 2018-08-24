defmodule Krusty.IngredientView do
  use Krusty.Web, :view

  def render("index.json", %{ingredients: ingredients}) do
    %{data: render_many(ingredients, Krusty.IngredientView, "ingredient.json")}
  end

  def render("show.json", %{ingredient: ingredient}) do
    %{data: render_one(ingredient, Krusty.IngredientView, "ingredient.json")}
  end

  def render("ingredient.json", %{ingredient: ingredient}) do
    data = %{
      id: ingredient.id,
      name: ingredient.name
    }

    if Ecto.assoc_loaded?(ingredient.deliveries) do
      deliveries = render_many(ingredient.deliveries, Krusty.DeliveryView, "delivery.json")
      Map.put(data, :deliveries, deliveries)
    else
      data
    end
  end
end
