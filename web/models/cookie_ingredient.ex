defmodule Krusty.CookieIngredient do
  use Krusty.Web, :model

  schema "cookie_ingredients" do
    field :amount, :integer
    belongs_to :cookie, Krusty.Cookie, foreign_key: :cookie_id
    belongs_to :ingredient, Krusty.Ingredient, foreign_key: :ingredient_id

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
