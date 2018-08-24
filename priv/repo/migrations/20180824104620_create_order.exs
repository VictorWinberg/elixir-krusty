defmodule Krusty.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :date, :date
      add :status, :integer
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:customer_id])
  end
end
