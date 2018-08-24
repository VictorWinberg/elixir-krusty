defmodule Krusty.OrderTest do
  use Krusty.ModelCase

  alias Krusty.Order

  @valid_attrs %{date: ~D[2010-04-17], status: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
