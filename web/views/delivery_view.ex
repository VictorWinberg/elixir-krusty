defmodule Krusty.DeliveryView do
  use Krusty.Web, :view

  def render("index.json", %{deliveries: deliveries}) do
    %{data: render_many(deliveries, Krusty.DeliveryView, "delivery.json")}
  end

  def render("show.json", %{delivery: delivery}) do
    %{data: render_one(delivery, Krusty.DeliveryView, "delivery.json")}
  end

  def render("delivery.json", %{delivery: delivery}) do
    %{id: delivery.id,
      amount: delivery.amount,
      date: delivery.date,
      ingredient_id: delivery.ingredient_id}
  end
end
