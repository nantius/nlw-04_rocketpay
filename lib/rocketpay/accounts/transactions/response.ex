defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:from_account, :to_account]
  def build(%Account{} = from, %Account{} = to) do
    %__MODULE__{
      from_account: from,
      to_account: to
    }
  end
end
