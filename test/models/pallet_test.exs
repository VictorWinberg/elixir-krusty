defmodule Krusty.PalletTest do
  use Krusty.ModelCase

  alias Krusty.Pallet

  @valid_attrs %{date: ~D[2010-04-17], label: "some label", status: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pallet.changeset(%Pallet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pallet.changeset(%Pallet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
