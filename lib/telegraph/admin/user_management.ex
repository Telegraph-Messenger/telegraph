defmodule Telegraph.Admin.UserManagement do
  alias Telegraph.Accounts.User
  alias Telegraph.Repo
  import Ecto.Query

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.admin_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.admin_changeset(attrs)
    |> Repo.update()
  end

  def change_user(%User{} = user, attrs \\ %{}, opts \\ []) do
    User.admin_changeset(user, attrs, opts)
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def list_users(params) do
    from(u in User)
    |> filter_by_email(params)
    |> filter_by_admin_status(params)
    |> Repo.all()
  end

  defp filter_by_email(query, %{"email" => email}) when is_binary(email) and email != "" do
    where(query, [u], ilike(u.email, ^"%#{email}%"))
  end

  defp filter_by_email(query, _), do: query

  defp filter_by_admin_status(query, %{"is_admin" => is_admin}) when is_binary(is_admin) do
    case is_admin do
      "true" -> where(query, [u], u.is_admin == true)
      "false" -> where(query, [u], u.is_admin == false)
      _ -> query
    end
  end

  defp filter_by_admin_status(query, _), do: query
end
