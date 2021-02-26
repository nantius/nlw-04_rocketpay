defmodule Rocketpay.Account do
    import Ecto.Changeset
    use Ecto.Schema
    alias Rocketpay.User

    @primary_key {:id, :binary_id, autogenerate: true}
    @foreign_key_type :binary_id
    @required_params [:balance, :user_id]

    schema "accounts" do
      field :balance, :decimal
      belongs_to :user, User

      timestamps()
    end

    def changeset(params) do
      %__MODULE__{}
      |> cast(params, @required_params)
      |> validate_required(@required_params)
      |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
    end

  end
