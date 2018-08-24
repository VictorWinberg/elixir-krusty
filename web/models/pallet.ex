defmodule Krusty.Pallet do
  use Krusty.Web, :model

  schema "pallets" do
    field :label, :string
    field :date, :date
    field :status, :integer
    belongs_to :cookie, Krusty.Cookie, foreign_key: :cookie_id
    belongs_to :order, Krusty.Order, foreign_key: :order_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:label, :date, :status])
    |> validate_required([:label, :date, :status])
  end
end
