defmodule Gymsys.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gymsys.Accounts` context.
  """

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        is_active: true,
        last_login: ~U[2026-08-15 14:14:00Z],
        name: "some name",
        password_hash: "some password_hash",
        username: unique_user_username()
      })
      |> Gymsys.Accounts.create_user()

    user
  end

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        is_active: true,
        last_login: ~U[2026-08-15 14:16:00Z],
        name: "some name",
        password_hash: "some password_hash",
        username: unique_user_username()
      })
      |> Gymsys.Accounts.create_user()

    user
  end
end
