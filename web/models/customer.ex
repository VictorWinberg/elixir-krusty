defmodule Krusty.Customer do
  use Krusty.Web, :model

  schema "customers" do
    field :name, :string
    field :address, :string
    has_many :orders, Krusty.Order

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address])
    |> validate_required([:name, :address])
  end
end
