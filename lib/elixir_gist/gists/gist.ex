defmodule ElixirGist.Gists.Gist do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "gists" do
    field :names, :string
    field :description, :string
    field :markup_text, :string
    belongs_to :user, ElixirGist.Accounts.User
    has_many :comment, ElixirGist.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(gist, attrs, user_scope) do
    gist
    |> cast(attrs, [:names, :description, :markup_text, :user_id])
    |> validate_required([:names, :description, :markup_text, :user_id])
    |> put_change(:user_id, user_scope.user.id)
  end
end
