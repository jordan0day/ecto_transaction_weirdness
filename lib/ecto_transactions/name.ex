defmodule Name do
  use Ecto.Model

  schema "names" do
    field :first_name
    field :last_name

    timestamps
  end
end