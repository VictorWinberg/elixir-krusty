defmodule Krusty.PalletController do
  use Krusty.Web, :controller

  alias Krusty.Pallet

  def index(conn, _params) do
    pallets = Repo.all(Pallet)
    render(conn, "index.json", pallets: pallets)
  end

  def create(conn, %{"pallet" => pallet_params}) do
    changeset = Pallet.changeset(%Pallet{}, pallet_params)

    case Repo.insert(changeset) do
      {:ok, pallet} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", pallet_path(conn, :show, pallet))
        |> render("show.json", pallet: pallet)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pallet = Repo.get!(Pallet, id)
    render(conn, "show.json", pallet: pallet)
  end

  def update(conn, %{"id" => id, "pallet" => pallet_params}) do
    pallet = Repo.get!(Pallet, id)
    changeset = Pallet.changeset(pallet, pallet_params)

    case Repo.update(changeset) do
      {:ok, pallet} ->
        render(conn, "show.json", pallet: pallet)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pallet = Repo.get!(Pallet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pallet)

    send_resp(conn, :no_content, "")
  end
end
