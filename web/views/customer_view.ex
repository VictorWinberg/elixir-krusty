defmodule Krusty.CustomerView do
  use Krusty.Web, :view

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, Krusty.CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, Krusty.CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name,
      address: customer.address}
  end
end
