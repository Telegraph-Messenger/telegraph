defmodule Telegraph.AdminFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Telegraph.Admin` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        confirmed_at: ~N[2024-09-30 16:57:00],
        email: "some email",
        is_admin: true
      })
      |> Telegraph.Admin.create_user()

    user
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        confirmed_at: ~N[2024-10-01 01:20:00],
        email: "some email",
        is_admin: true,
        password: "some password"
      })
      |> Telegraph.Admin.create_user()

    user
  end
end
