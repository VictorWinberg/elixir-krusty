defmodule Krusty.Repo.Migrations.CreateCookie do
  use Ecto.Migration

  def change do
    create table(:cookies) do
      add :name, :string

      timestamps()
    end
  end
end
