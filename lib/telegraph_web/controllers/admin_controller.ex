defmodule TelegraphWeb.AdminController do
  use TelegraphWeb, :controller

  def index(conn, _params) do
    render(conn, :index, message: "Welcome to the Admin Dashboard")
    # render(conn, :hello, message: "Welcome to the Admin Dashboard")
  end

  def users(conn, _params) do
    # Here you would typically fetch users from your database
    # For now, let's just pass a list of sample users
    users = [
      %{id: 1, name: "Alice", is_admin: true},
      %{id: 2, name: "Bob", is_admin: false},
      %{id: 3, name: "Charlie", is_admin: false}
    ]

    render(conn, :users, users: users)
  end
end
