defmodule Hello.ElixirbridgeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Elixirbridge` context.
  """

  @doc """
  Generate a drink.
  """
  def drink_fixture(attrs \\ %{}) do
    {:ok, drink} =
      attrs
      |> Enum.into(%{
        name: "some name",
        temperature: "some temperature"
      })
      |> Hello.Elixirbridge.create_drink()

    drink
  end
end
