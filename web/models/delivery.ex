defmodule Krusty.Delivery do
  use Krusty.Web, :model

  schema "deliveries" do
    field :amount, :integer
    field :date, :date
    belongs_to :ingredient, Krusty.Ingredient, foreign_key: :ingredient_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :date])
    |> validate_required([:amount, :date])
  end
end
