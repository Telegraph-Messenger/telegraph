defmodule TelegraphWeb.Admin.UsersController do
  use TelegraphWeb, :controller

  def index(conn, _params) do
    # Fetch users from the database
    users = Telegraph.Repo.all(Telegraph.User)
    render(conn, "index.html", users: users)
  end
end
