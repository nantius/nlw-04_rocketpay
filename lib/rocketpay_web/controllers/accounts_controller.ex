defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller
  use PhoenixSwagger

  alias Rocketpay.Account

  action_fallback RocketpayWeb.FallbackController


  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:created)
      |> render("update.json", account: account)
    end
  end

  swagger_path :deposit do
    post("/api/accounts/:id/deposit")
    produces ("application/json")
    tag ("Accounts")
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
end
