defmodule Hello.Elixirbridge.Drink do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drinks" do
    field :name, :string
    field :temperature, :string

    timestamps()
  end

  @doc false
  def changeset(drink, attrs) do
    drink
    |> cast(attrs, [:name, :temperature])
    |> validate_required([:name, :temperature])
  end
end
