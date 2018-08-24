defmodule Krusty.PalletView do
  use Krusty.Web, :view

  def render("index.json", %{pallets: pallets}) do
    %{data: render_many(pallets, Krusty.PalletView, "pallet.json")}
  end

  def render("show.json", %{pallet: pallet}) do
    %{data: render_one(pallet, Krusty.PalletView, "pallet.json")}
  end

  def render("pallet.json", %{pallet: pallet}) do
    %{id: pallet.id,
      label: pallet.label,
      date: pallet.date,
      status: pallet.status,
      cookie_id: pallet.cookie_id,
      order_id: pallet.order_id}
  end
end
