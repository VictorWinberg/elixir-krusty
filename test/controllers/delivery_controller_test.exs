defmodule Krusty.DeliveryControllerTest do
  use Krusty.ConnCase

  alias Krusty.Delivery
  @valid_attrs %{amount: 42, date: ~D[2010-04-17]}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, delivery_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = get conn, delivery_path(conn, :show, delivery)
    assert json_response(conn, 200)["data"] == %{"id" => delivery.id,
      "amount" => delivery.amount,
      "date" => delivery.date,
      "ingredient_id" => delivery.ingredient_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, delivery_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, delivery_path(conn, :create), delivery: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Delivery, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, delivery_path(conn, :create), delivery: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = put conn, delivery_path(conn, :update, delivery), delivery: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Delivery, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = put conn, delivery_path(conn, :update, delivery), delivery: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = delete conn, delivery_path(conn, :delete, delivery)
    assert response(conn, 204)
    refute Repo.get(Delivery, delivery.id)
  end
end
