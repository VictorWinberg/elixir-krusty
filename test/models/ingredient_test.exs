defmodule Krusty.IngredientTest do
  use Krusty.ModelCase

  alias Krusty.Ingredient

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ingredient.changeset(%Ingredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ingredient.changeset(%Ingredient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
