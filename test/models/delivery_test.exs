defmodule Krusty.DeliveryTest do
  use Krusty.ModelCase

  alias Krusty.Delivery

  @valid_attrs %{amount: 42, date: ~D[2010-04-17]}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Delivery.changeset(%Delivery{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Delivery.changeset(%Delivery{}, @invalid_attrs)
    refute changeset.valid?
  end
end
