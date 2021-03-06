defmodule Krusty.Cookie do
  use Krusty.Web, :model

  schema "cookies" do
    field :name, :string
    has_many :pallets, Krusty.Pallet
    has_many :ingredients, Krusty.CookieIngredient
    has_many :orders, Krusty.CookieOrder

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
