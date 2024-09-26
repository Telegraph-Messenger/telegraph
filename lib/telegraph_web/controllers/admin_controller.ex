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
    {:ok, _updated_user} = Accounts.update_user(user, %{is_admin: true})

    conn
    |> put_flash(:info, "User has been made an admin.")
    |> redirect(to: ~p"/admin/users")
  end
end
