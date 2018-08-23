defmodule Krusty.CookieControllerTest do
  use Krusty.ConnCase

  alias Krusty.Cookie
  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cookie_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    cookie = Repo.insert! %Cookie{}
    conn = get conn, cookie_path(conn, :show, cookie)
    assert json_response(conn, 200)["data"] == %{"id" => cookie.id,
      "name" => cookie.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, cookie_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, cookie_path(conn, :create), cookie: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Cookie, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cookie_path(conn, :create), cookie: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    cookie = Repo.insert! %Cookie{}
    conn = put conn, cookie_path(conn, :update, cookie), cookie: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Cookie, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cookie = Repo.insert! %Cookie{}
    conn = put conn, cookie_path(conn, :update, cookie), cookie: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    cookie = Repo.insert! %Cookie{}
    conn = delete conn, cookie_path(conn, :delete, cookie)
    assert response(conn, 204)
    refute Repo.get(Cookie, cookie.id)
  end
end
