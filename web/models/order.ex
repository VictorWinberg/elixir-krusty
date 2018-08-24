defmodule Krusty.Order do
  use Krusty.Web, :model

  schema "orders" do
    field :date, :date
    field :status, :integer
    belongs_to :customer, Krusty.Customer, foreign_key: :customer_id
    has_many :pallets, Krusty.Pallet

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:date, :status])
    |> validate_required([:date, :status])
  end
end
