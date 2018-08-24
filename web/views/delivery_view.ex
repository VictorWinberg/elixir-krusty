defmodule Krusty.DeliveryView do
  use Krusty.Web, :view

  def render("index.json", %{deliveries: deliveries}) do
    %{data: render_many(deliveries, Krusty.DeliveryView, "delivery.json")}
  end

  def render("show.json", %{delivery: delivery}) do
    %{data: render_one(delivery, Krusty.DeliveryView, "delivery.json")}
  end

  def render("delivery.json", %{delivery: delivery}) do
    data = %{
      id: delivery.id,
      amount: delivery.amount,
      date: delivery.date
    }

    if Ecto.assoc_loaded?(delivery.ingredient) do
      ingredient = render_one(delivery.ingredient, Krusty.IngredientView, "ingredient.json")
      Map.put(data, :ingredient, ingredient)
    else
      data
    end
  end
end
