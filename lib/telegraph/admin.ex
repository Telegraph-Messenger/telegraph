defmodule Telegraph.Admin do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Telegraph.Repo

  alias Telegraph.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.admin_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.admin_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.admin_changeset(user, attrs)
  end

  @doc """
  Returns the list of users with optional filtering.

  ## Examples

      iex> list_users(%{"email" => "test@example.com", "is_admin" => "true"})
      [%User{}, ...]

  """
  def list_users(params \\ %{}) do
    User
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
