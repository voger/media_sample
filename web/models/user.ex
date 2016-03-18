defmodule ForEctoUpgrade.User do
  use ForEctoUpgrade.Web, :model
  use ForEctoUpgrade.UserModelPasswordConcern, min_password_length: 8, max_password_length: 10

  schema "users" do
    field :email, :string
    field :name, :string
    field :encrypted_password, :string
    field :profile, :string
    field :image, :string
    field :status, :integer

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(email name profile status)a
  @optional_fields ~w()a

  def changeset(user, params \\ %{}) do
    {required_fields, optional_fields} = adjust_validation_fields(user, @required_fields, @optional_fields)

    user
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> check_password
  end
end
