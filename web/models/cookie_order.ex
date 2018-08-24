defmodule Krusty.CookieOrder do
  use Krusty.Web, :model

  schema "cookie_orders" do
    field :amount, :integer
    belongs_to :cookie, Krusty.Cookie, foreign_key: :cookie_id
    belongs_to :order, Krusty.Order, foreign_key: :order_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount])
    |> validate_required([:amount])
  end
end
