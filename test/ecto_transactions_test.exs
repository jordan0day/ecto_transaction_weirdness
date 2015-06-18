defmodule EctoTransactionsTest do
  use ExUnit.Case

  alias EctoTransactions.Repo
  alias Name

  setup do
    Repo.delete_all(Name)

    :ok
  end

  # The %Name{} table has a unique index on firstname, lastname, so attempts
  # to insert identical records will fail with a Postgrex error: 
  # "** (Postgrex.Error) ERROR (unique_violation): duplicate key value violates unique constraint "names_first_name_last_name_index"
  test "try to insert a name a lot" do
    first_name = "test"
    last_name = "user"

    name = %Name{first_name: first_name, last_name: last_name}

    IO.puts "Here 1"

    result = Repo.transaction(fn ->
      Repo.insert(name)
    end)

    IO.puts "Here 2"

    case result do
      {:ok, _record} -> IO.puts "A-OK!"
      {:error, error} -> IO.puts "uh-oh: #{inspect error}"
    end

    IO.puts "Here 3"

    result = Repo.transaction(fn ->
      Repo.insert(name)
    end)

    IO.puts "Don't seem to be getting to here..."

    case result do
      {:ok, _record} -> IO.puts "A-OK!"
      {:error, error} -> IO.puts "Well, at least the transaction seems to have caught it: #{inspect error}"
    end
  end
end
