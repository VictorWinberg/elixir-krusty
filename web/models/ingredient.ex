defmodule Krusty.Ingredient do
  use Krusty.Web, :model

  schema "ingredients" do
    field :name, :string
    field :amount, :integer, virtual: true
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

  def get(query) do
    from(
      ingredient in query,
      left_join: delivery in assoc(ingredient, :deliveries),
      group_by: ingredient.id,
      select: %{ingredient | amount: sum(delivery.amount)}
    )
  end
end
