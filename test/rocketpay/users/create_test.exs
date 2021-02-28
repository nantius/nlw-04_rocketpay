defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Leonardo",
        password: "123456",
        nickname: "Leo",
        email: "spdleonardo@hotmail.com",
        age: 28
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Leonardo", age: 28, id: ^user_id} = user
    end

    test "when there are invalid params returns errors" do
      params = %{
        name: "Leonardo",
        nickname: "Leo",
        email: "spdleonardo@hotmail.com",
        age: 15
      }

      expected_response = %{
        password: ["can't be blank"]
      }

      {:error, changeset} = Create.call(params)

      assert errors_on(changeset) == expected_response
    end
  end
end
