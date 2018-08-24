defmodule Krusty.Repo.Migrations.CreateCookieIngredient do
  use Ecto.Migration

  def change do
    create table(:cookie_ingredients) do
      add :amount, :integer
      add :cookie_id, references(:cookies, on_delete: :nothing)
      add :ingredient_id, references(:ingredients, on_delete: :nothing)

      timestamps()
    end

    create index(:cookie_ingredients, [:cookie_id])
    create index(:cookie_ingredients, [:ingredient_id])
  end
end
