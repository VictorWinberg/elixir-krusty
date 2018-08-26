defmodule Krusty.CookieIngredientController do
  use Krusty.Web, :controller

  alias Krusty.{Cookie, CookieIngredient}

  def create(conn, %{"ingredient" => ingredient_params, "cookie_id" => cookie_id}) do
    cookie = Repo.get(Cookie, cookie_id)
    changeset = cookie
                |> Ecto.build_assoc(:ingredients)
                |> CookieIngredient.changeset(ingredient_params)

    case Repo.insert(changeset) do
      {:ok, ingredient} ->
        conn
        |> redirect(to: cookie_path(conn, :show, cookie))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
