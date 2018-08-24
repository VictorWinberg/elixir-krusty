defmodule Krusty.Repo.Migrations.CreatePallet do
  use Ecto.Migration

  def change do
    create table(:pallets) do
      add :label, :string
      add :date, :date
      add :status, :integer
      add :cookie_id, references(:cookies, on_delete: :nothing)
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create index(:pallets, [:cookie_id])
    create index(:pallets, [:order_id])
  end
end
