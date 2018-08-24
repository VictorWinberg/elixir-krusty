defmodule Krusty.CookieIngredientTest do
  use Krusty.ModelCase

  alias Krusty.CookieIngredient

  @valid_attrs %{amount: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CookieIngredient.changeset(%CookieIngredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CookieIngredient.changeset(%CookieIngredient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
