defmodule Krusty.Ingredient do
  use Krusty.Web, :model

  schema "ingredients" do
    field :name, :string
    has_many :deliveries, Krusty.Delivery

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
