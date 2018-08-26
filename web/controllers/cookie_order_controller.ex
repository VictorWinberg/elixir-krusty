defmodule Krusty.CookieOrderController do
  use Krusty.Web, :controller

  alias Krusty.{Cookie, CookieOrder}

  def create(conn, %{"order" => order_params, "cookie_id" => cookie_id}) do
    cookie = Repo.get(Cookie, cookie_id)
    changeset = cookie
                |> Ecto.build_assoc(:orders)
                |> CookieOrder.changeset(order_params)

    case Repo.insert(changeset) do
      {:ok, order} ->
        conn
        |> redirect(to: cookie_path(conn, :show, cookie))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
