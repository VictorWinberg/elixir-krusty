defmodule Krusty.CustomerTest do
  use Krusty.ModelCase

  alias Krusty.Customer

  @valid_attrs %{address: "some address", name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Customer.changeset(%Customer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Customer.changeset(%Customer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
