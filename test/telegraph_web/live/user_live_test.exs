defmodule TelegraphWeb.UserLiveTest do
  use TelegraphWeb.ConnCase

  import Phoenix.LiveViewTest
  import Telegraph.AdminFixtures

  @create_attrs %{password: "some password", email: "some email", confirmed_at: "2024-10-01T01:20:00", is_admin: true}
  @update_attrs %{password: "some updated password", email: "some updated email", confirmed_at: "2024-10-02T01:20:00", is_admin: false}
  @invalid_attrs %{password: nil, email: nil, confirmed_at: nil, is_admin: false}

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  describe "Index" do
    setup [:create_user]

    test "lists all users", %{conn: conn, user: user} do
      {:ok, _index_live, html} = live(conn, ~p"/users")

      assert html =~ "Listing Users"
      assert html =~ user.password
    end

    test "saves new user", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("a", "New User") |> render_click() =~
               "New User"

      assert_patch(index_live, ~p"/users/new")

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user-form", user: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "User created successfully"
      assert html =~ "some password"
    end

    test "updates user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{user.id} a", "Edit") |> render_click() =~
               "Edit User"

      assert_patch(index_live, ~p"/users/#{user}/edit")

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user-form", user: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "User updated successfully"
      assert html =~ "some updated password"
    end

    test "deletes user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{user.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#users-#{user.id}")
    end
  end

  describe "Show" do
    setup [:create_user]

    test "displays user", %{conn: conn, user: user} do
      {:ok, _show_live, html} = live(conn, ~p"/users/#{user}")

      assert html =~ "Show User"
      assert html =~ user.password
    end

    test "updates user within modal", %{conn: conn, user: user} do
      {:ok, show_live, _html} = live(conn, ~p"/users/#{user}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User"

      assert_patch(show_live, ~p"/users/#{user}/show/edit")

      assert show_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user-form", user: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/users/#{user}")

      html = render(show_live)
      assert html =~ "User updated successfully"
      assert html =~ "some updated password"
    end
  end
end
