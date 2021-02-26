defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller
  use PhoenixSwagger

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  swagger_path :create do
    post("/api/users")
    produces ("application/json")
    tag ("Users")
    description("User creation")

    parameters do
      name     :body, :string, "Leonardo Spuldar",       required: true
      nickname :body, :string, "spdleo",                 required: true
      email    :body, :string, "spuldardev@hotmail.com", required: true
      password :body, :string, "123456",                 required: true
      age      :body, :integer, 27,                      required: true
    end

    response 200, "ok", Schema.ref(:User)
    response 400, "Client Error"
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("A user of the application")

          properties do
            name(:string, "Users name", required: true)
            age(:integer, "Users age", required: true)
            email(:string, "Users email", required: true)
            nickname(:string, "Users nickname", required: true)
            password(:string, "Users password", required: true)
          end
        end
    }
  end

  # defp handle_response({:ok, %User{} = user}, conn) do
  #   conn
  #   |> put_status(:created)
  #   |> render("create.json", user: user)
  # end

  # defp handle_response({:error, _result} = error, _conn), do: error
end
