defmodule Krusty.Repo.Migrations.CreateCookieOrder do
  use Ecto.Migration

  def change do
    create table(:cookie_orders) do
      add :amount, :integer
      add :cookie_id, references(:cookies, on_delete: :nothing)
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create index(:cookie_orders, [:cookie_id])
    create index(:cookie_orders, [:order_id])
  end
end
