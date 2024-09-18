defmodule UserManagement do
  defstruct id: "", name: ""

  def register_user(users, user) do
    [user | users]
  end

  def list_users(users) do
    users
  end
end