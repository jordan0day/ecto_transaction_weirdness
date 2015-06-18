defmodule EctoTransactions.Repo.Migrations.AddNamesTable do
  use Ecto.Migration

  def change do
    create table(:names) do
      add :first_name, :string
      add :last_name,  :string

      timestamps
    end

    create index(:names, [:first_name, :last_name], unique: true)
  end
end
