defmodule HelloWeb.DrinkController do
  use HelloWeb, :controller

  alias Hello.Elixirbridge
  alias Hello.Elixirbridge.Drink

  def index(conn, _params) do
    drinks = Elixirbridge.list_drinks()
    render(conn, :index, drinks: drinks)
  end

  def new(conn, _params) do
    changeset = Elixirbridge.change_drink(%Drink{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"drink" => drink_params}) do
    case Elixirbridge.create_drink(drink_params) do
      {:ok, drink} ->
        conn
        |> put_flash(:info, "Drink created successfully.")
        |> redirect(to: ~p"/drinks/#{drink}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    drink = Elixirbridge.get_drink!(id)
    render(conn, :show, drink: drink)
  end

  def edit(conn, %{"id" => id}) do
    drink = Elixirbridge.get_drink!(id)
    changeset = Elixirbridge.change_drink(drink)
    render(conn, :edit, drink: drink, changeset: changeset)
  end

  def update(conn, %{"id" => id, "drink" => drink_params}) do
    drink = Elixirbridge.get_drink!(id)

    case Elixirbridge.update_drink(drink, drink_params) do
      {:ok, drink} ->
        conn
        |> put_flash(:info, "Drink updated successfully.")
        |> redirect(to: ~p"/drinks/#{drink}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, drink: drink, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    drink = Elixirbridge.get_drink!(id)
    {:ok, _drink} = Elixirbridge.delete_drink(drink)

    conn
    |> put_flash(:info, "Drink deleted successfully.")
    |> redirect(to: ~p"/drinks")
  end
end
