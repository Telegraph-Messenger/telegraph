defmodule Telegraph.AdminTest do
  use Telegraph.DataCase

  alias Telegraph.Admin

  describe "users" do
    alias Telegraph.Admin.User

    import Telegraph.AdminFixtures

    @invalid_attrs %{email: nil, confirmed_at: nil, is_admin: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Admin.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Admin.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", confirmed_at: ~N[2024-09-30 16:57:00], is_admin: true}

      assert {:ok, %User{} = user} = Admin.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.confirmed_at == ~N[2024-09-30 16:57:00]
      assert user.is_admin == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", confirmed_at: ~N[2024-10-01 16:57:00], is_admin: false}

      assert {:ok, %User{} = user} = Admin.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.confirmed_at == ~N[2024-10-01 16:57:00]
      assert user.is_admin == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_user(user, @invalid_attrs)
      assert user == Admin.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admin.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admin.change_user(user)
    end
  end

  describe "users" do
    alias Telegraph.Admin.User

    import Telegraph.AdminFixtures

    @invalid_attrs %{password: nil, email: nil, confirmed_at: nil, is_admin: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Admin.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Admin.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{password: "some password", email: "some email", confirmed_at: ~N[2024-10-01 01:20:00], is_admin: true}

      assert {:ok, %User{} = user} = Admin.create_user(valid_attrs)
      assert user.password == "some password"
      assert user.email == "some email"
      assert user.confirmed_at == ~N[2024-10-01 01:20:00]
      assert user.is_admin == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{password: "some updated password", email: "some updated email", confirmed_at: ~N[2024-10-02 01:20:00], is_admin: false}

      assert {:ok, %User{} = user} = Admin.update_user(user, update_attrs)
      assert user.password == "some updated password"
      assert user.email == "some updated email"
      assert user.confirmed_at == ~N[2024-10-02 01:20:00]
      assert user.is_admin == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_user(user, @invalid_attrs)
      assert user == Admin.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admin.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admin.change_user(user)
    end
  end
end
