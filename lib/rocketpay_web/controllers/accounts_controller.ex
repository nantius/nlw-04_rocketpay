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

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
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
      value    :body, :string, "50.0",                                      required: true
      id       :query, :string, "adauhdsua1236-2371237isahd-2173y273y2",    required: true
    end

    response 200, "ok", Schema.ref(:Account)
    response 400, "Bad request"
  end

  def swagger_definitions do
    %{
      Account:
        swagger_schema do
          title("Account")
          description("An account linked to an User")

          properties do
            balance(:decimal, "Account balance", required: true)
          end
        end
    }
  end
end
