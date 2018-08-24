defmodule Krusty.PalletView do
  use Krusty.Web, :view

  def render("index.json", %{pallets: pallets}) do
    %{data: render_many(pallets, Krusty.PalletView, "pallet.json")}
  end

  def render("show.json", %{pallet: pallet}) do
    %{data: render_one(pallet, Krusty.PalletView, "pallet.json")}
  end

  def render("pallet.json", %{pallet: pallet}) do
    %{
      id: pallet.id,
      label: pallet.label,
      date: pallet.date,
      status: pallet.status
    }
    |> append_cookie(pallet.cookie)
    |> append_order(pallet.order)
  end

  defp append_cookie(data, cookie) do
    if Ecto.assoc_loaded?(cookie) do
      cookie = render_one(cookie, Krusty.CookieView, "cookie.json")
      Map.put(data, :cookie, cookie)
    else
      data
    end
  end

  defp append_order(data, order) do
    if Ecto.assoc_loaded?(order) do
      order = render_one(order, Krusty.OrderView, "order.json")
      Map.put(data, :order, order)
    else
      data
    end
  end
end
