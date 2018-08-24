defmodule Krusty.PalletControllerTest do
  use Krusty.ConnCase

  alias Krusty.Pallet
  @valid_attrs %{date: ~D[2010-04-17], label: "some label", status: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pallet_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    pallet = Repo.insert! %Pallet{}
    conn = get conn, pallet_path(conn, :show, pallet)
    assert json_response(conn, 200)["data"] == %{"id" => pallet.id,
      "label" => pallet.label,
      "date" => pallet.date,
      "status" => pallet.status,
      "cookie_id" => pallet.cookie_id,
      "order_id" => pallet.order_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, pallet_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, pallet_path(conn, :create), pallet: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Pallet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pallet_path(conn, :create), pallet: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    pallet = Repo.insert! %Pallet{}
    conn = put conn, pallet_path(conn, :update, pallet), pallet: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Pallet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pallet = Repo.insert! %Pallet{}
    conn = put conn, pallet_path(conn, :update, pallet), pallet: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    pallet = Repo.insert! %Pallet{}
    conn = delete conn, pallet_path(conn, :delete, pallet)
    assert response(conn, 204)
    refute Repo.get(Pallet, pallet.id)
  end
end
