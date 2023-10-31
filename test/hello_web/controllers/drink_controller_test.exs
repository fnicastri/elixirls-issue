defmodule HelloWeb.DrinkControllerTest do
  use HelloWeb.ConnCase

  import Hello.ElixirbridgeFixtures

  @create_attrs %{name: "some name", temperature: "some temperature"}
  @update_attrs %{name: "some updated name", temperature: "some updated temperature"}
  @invalid_attrs %{name: nil, temperature: nil}

  describe "index" do
    test "lists all drinks", %{conn: conn} do
      conn = get(conn, ~p"/drinks")
      assert html_response(conn, 200) =~ "Listing Drinks"
    end
  end

  describe "new drink" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/drinks/new")
      assert html_response(conn, 200) =~ "New Drink"
    end
  end

  describe "create drink" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/drinks", drink: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/drinks/#{id}"

      conn = get(conn, ~p"/drinks/#{id}")
      assert html_response(conn, 200) =~ "Drink #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/drinks", drink: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Drink"
    end
  end

  describe "edit drink" do
    setup [:create_drink]

    test "renders form for editing chosen drink", %{conn: conn, drink: drink} do
      conn = get(conn, ~p"/drinks/#{drink}/edit")
      assert html_response(conn, 200) =~ "Edit Drink"
    end
  end

  describe "update drink" do
    setup [:create_drink]

    test "redirects when data is valid", %{conn: conn, drink: drink} do
      conn = put(conn, ~p"/drinks/#{drink}", drink: @update_attrs)
      assert redirected_to(conn) == ~p"/drinks/#{drink}"

      conn = get(conn, ~p"/drinks/#{drink}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, drink: drink} do
      conn = put(conn, ~p"/drinks/#{drink}", drink: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Drink"
    end
  end

  describe "delete drink" do
    setup [:create_drink]

    test "deletes chosen drink", %{conn: conn, drink: drink} do
      conn = delete(conn, ~p"/drinks/#{drink}")
      assert redirected_to(conn) == ~p"/drinks"

      assert_error_sent 404, fn ->
        get(conn, ~p"/drinks/#{drink}")
      end
    end
  end

  defp create_drink(_) do
    drink = drink_fixture()
    %{drink: drink}
  end
end
