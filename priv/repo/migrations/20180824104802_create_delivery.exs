defmodule Krusty.Repo.Migrations.CreateDelivery do
  use Ecto.Migration

  def change do
    create table(:deliveries) do
      add :amount, :integer
      add :date, :date
      add :ingredient_id, references(:ingredients, on_delete: :nothing)

      timestamps()
    end

    create index(:deliveries, [:ingredient_id])
  end
end
