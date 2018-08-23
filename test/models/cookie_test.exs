defmodule Krusty.CookieTest do
  use Krusty.ModelCase

  alias Krusty.Cookie

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cookie.changeset(%Cookie{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cookie.changeset(%Cookie{}, @invalid_attrs)
    refute changeset.valid?
  end
end
