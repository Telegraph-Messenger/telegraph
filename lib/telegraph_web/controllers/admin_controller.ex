defmodule TelegraphWeb.AdminController do
  use TelegraphWeb, :controller
  alias Telegraph.Accounts

  def index(conn, _params) do
    render(conn, :index,
      layout: {TelegraphWeb.Layouts, :admin},
      message: "Welcome to the Admin Dashboard"
    )

    # render(conn, :hello, message: "Welcome to the Admin Dashboard")
  end

  def users(conn, _params) do
    users = Accounts.list_users()
    render(conn, :users, users: users, layout: {TelegraphWeb.Layouts, :admin})
  end

  def make_admin(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, %{is_admin: true}) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User has been promoted to admin.")
        |> redirect(to: ~p"/admin/users")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to promote user to admin.")
        |> redirect(to: ~p"/admin/users")
    end
  end

  def demote_admin(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user
    user = Accounts.get_user!(id)

    if user.id == current_user.id do
      conn
      |> put_flash(:error, "You cannot demote yourself.")
      |> redirect(to: ~p"/admin/users")
    else
      case Accounts.update_user(user, %{is_admin: false}) do
        {:ok, _user} ->
          conn
          |> put_flash(:info, "Admin has been demoted to regular user.")
          |> redirect(to: ~p"/admin/users")

        {:error, _changeset} ->
          conn
          |> put_flash(:error, "Failed to demote admin.")
          |> redirect(to: ~p"/admin/users")
      end
    end
  end
end
