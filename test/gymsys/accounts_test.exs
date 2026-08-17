defmodule Gymsys.AccountsTest do
  use Gymsys.DataCase

  alias Gymsys.Accounts

  describe "users" do
    alias Gymsys.Accounts.User

    import Gymsys.AccountsFixtures

    @invalid_attrs %{name: nil, username: nil, password_hash: nil, is_active: nil, last_login: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", username: "some username", password_hash: "some password_hash", is_active: true, last_login: ~U[2026-08-15 14:14:00Z]}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
      assert user.password_hash == "some password_hash"
      assert user.is_active == true
      assert user.last_login == ~U[2026-08-15 14:14:00Z]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", username: "some updated username", password_hash: "some updated password_hash", is_active: false, last_login: ~U[2026-08-16 14:14:00Z]}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.username == "some updated username"
      assert user.password_hash == "some updated password_hash"
      assert user.is_active == false
      assert user.last_login == ~U[2026-08-16 14:14:00Z]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "users" do
    alias Gymsys.Accounts.User

    import Gymsys.AccountsFixtures

    @invalid_attrs %{name: nil, username: nil, password_hash: nil, is_active: nil, last_login: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", username: "some username", password_hash: "some password_hash", is_active: true, last_login: ~U[2026-08-15 14:16:00Z]}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
      assert user.password_hash == "some password_hash"
      assert user.is_active == true
      assert user.last_login == ~U[2026-08-15 14:16:00Z]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", username: "some updated username", password_hash: "some updated password_hash", is_active: false, last_login: ~U[2026-08-16 14:16:00Z]}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.username == "some updated username"
      assert user.password_hash == "some updated password_hash"
      assert user.is_active == false
      assert user.last_login == ~U[2026-08-16 14:16:00Z]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
