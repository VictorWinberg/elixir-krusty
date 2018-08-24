defmodule Krusty.CustomerView do
  use Krusty.Web, :view

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, Krusty.CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, Krusty.CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    data = %{
      id: customer.id,
      name: customer.name,
      address: customer.address
    }

    if Ecto.assoc_loaded?(customer.orders) do
      orders = render_many(customer.orders, Krusty.OrderView, "order.json")
      Map.put(data, :orders, orders)
    else
      data
    end
  end
end
