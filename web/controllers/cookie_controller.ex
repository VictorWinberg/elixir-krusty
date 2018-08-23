defmodule Krusty.CookieController do
  use Krusty.Web, :controller

  alias Krusty.Cookie

  def index(conn, _params) do
    cookies = Repo.all(Cookie)
    render(conn, "index.json", cookies: cookies)
  end

  def create(conn, %{"cookie" => cookie_params}) do
    changeset = Cookie.changeset(%Cookie{}, cookie_params)

    case Repo.insert(changeset) do
      {:ok, cookie} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", cookie_path(conn, :show, cookie))
        |> render("show.json", cookie: cookie)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cookie = Repo.get!(Cookie, id)
    render(conn, "show.json", cookie: cookie)
  end

  def update(conn, %{"id" => id, "cookie" => cookie_params}) do
    cookie = Repo.get!(Cookie, id)
    changeset = Cookie.changeset(cookie, cookie_params)

    case Repo.update(changeset) do
      {:ok, cookie} ->
        render(conn, "show.json", cookie: cookie)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cookie = Repo.get!(Cookie, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cookie)

    send_resp(conn, :no_content, "")
  end
end
