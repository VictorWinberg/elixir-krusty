defmodule Krusty.DeliveryController do
  use Krusty.Web, :controller

  alias Krusty.Delivery

  def index(conn, _params) do
    deliveries = Repo.all(Delivery)
    render(conn, "index.json", deliveries: deliveries)
  end

  def create(conn, %{"delivery" => delivery_params}) do
    changeset = Delivery.changeset(%Delivery{}, delivery_params)

    case Repo.insert(changeset) do
      {:ok, delivery} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", delivery_path(conn, :show, delivery))
        |> render("show.json", delivery: delivery)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    delivery = Repo.get!(Delivery, id)
    render(conn, "show.json", delivery: delivery)
  end

  def update(conn, %{"id" => id, "delivery" => delivery_params}) do
    delivery = Repo.get!(Delivery, id)
    changeset = Delivery.changeset(delivery, delivery_params)

    case Repo.update(changeset) do
      {:ok, delivery} ->
        render(conn, "show.json", delivery: delivery)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Krusty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    delivery = Repo.get!(Delivery, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(delivery)

    send_resp(conn, :no_content, "")
  end
end
