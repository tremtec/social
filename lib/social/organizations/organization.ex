defmodule Social.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "organizations" do
    field :slug, :string
    field :name, :string
    field :cnpj, :string
    field :description, :string
    field :mission, :string
    field :founding_date, :date

    many_to_many :users, Social.Accounts.User, join_through: Social.Organizations.OrganizationUser

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:slug, :name, :cnpj, :description, :mission, :founding_date])
    |> validate_required([:slug, :name, :cnpj, :description, :mission, :founding_date])
    |> validate_name()
    |> validate_slug()
    |> validate_cnpj()
    |> validate_description()
    |> validate_mission()
    |> validate_founding_date()
    |> unique_constraint(:cnpj, message: "this CNPJ is already registered")
    |> unique_constraint(:slug, message: "this URL slug is already taken, please choose another")
  end

  defp validate_name(changeset) do
    validate_change(changeset, :name, fn _, name ->
      cond do
        is_nil(name) or name == "" ->
          []

        String.length(String.trim(name)) < 2 ->
          [name: "must be at least 2 characters"]

        String.length(name) > 100 ->
          [name: "must be at most 100 characters"]

        true ->
          []
      end
    end)
  end

  defp validate_slug(changeset) do
    validate_change(changeset, :slug, fn _, slug ->
      cond do
        is_nil(slug) or slug == "" ->
          []

        not Regex.match?(~r/^[a-z0-9][a-z0-9-]*$/, slug) ->
          [
            slug:
              "must contain only lowercase letters, numbers, and hyphens (cannot start or end with hyphen)"
          ]

        String.length(slug) < 3 ->
          [slug: "must be at least 3 characters"]

        String.length(slug) > 50 ->
          [slug: "must be at most 50 characters"]

        true ->
          []
      end
    end)
  end

  defp validate_cnpj(changeset) do
    validate_change(changeset, :cnpj, fn _, cnpj ->
      if cnpj do
        # Remove formatting characters
        clean_cnpj = String.replace(cnpj, ~r/[.\/-]/, "")

        if String.length(clean_cnpj) != 14 do
          [cnpj: "must be a valid CNPJ (14 digits)"]
        else
          # Basic check digit validation for CNPJ
          if valid_cnpj?(clean_cnpj), do: [], else: [cnpj: "is not a valid CNPJ"]
        end
      else
        []
      end
    end)
  end

  # CNPJ validation using the standard algorithm
  defp valid_cnpj?(cnpj) when is_binary(cnpj) do
    cnpj
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> valid_cnpj?()
  end

  defp valid_cnpj?([d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12 | check_digits]) do
    # First check digit
    # Weights for d1-d12: 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2
    sum1 =
      d1 * 5 + d2 * 4 + d3 * 3 + d4 * 2 + d5 * 9 + d6 * 8 + d7 * 7 + d8 * 6 + d9 * 5 +
        d10 * 4 + d11 * 3 + d12 * 2

    remainder1 = rem(sum1, 11)
    expected1 = if remainder1 < 2, do: 0, else: 11 - remainder1

    # Second check digit
    # Weights for d1-d13: 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2
    sum2 =
      d1 * 6 + d2 * 5 + d3 * 4 + d4 * 3 + d5 * 2 + d6 * 9 + d7 * 8 + d8 * 7 + d9 * 6 +
        d10 * 5 + d11 * 4 + d12 * 3 + expected1 * 2

    remainder2 = rem(sum2, 11)
    expected2 = if remainder2 < 2, do: 0, else: 11 - remainder2

    [actual1, actual2] = check_digits
    expected1 == actual1 and expected2 == actual2
  end

  defp valid_cnpj?(_), do: false

  defp validate_description(changeset) do
    validate_change(changeset, :description, fn _, desc ->
      cond do
        is_nil(desc) or desc == "" ->
          []

        String.length(String.trim(desc)) < 10 ->
          [description: "must be at least 10 characters"]

        String.length(desc) > 1000 ->
          [description: "must be at most 1000 characters"]

        true ->
          []
      end
    end)
  end

  defp validate_mission(changeset) do
    validate_change(changeset, :mission, fn _, mission ->
      cond do
        is_nil(mission) or mission == "" ->
          []

        String.length(String.trim(mission)) < 10 ->
          [mission: "must be at least 10 characters"]

        String.length(mission) > 500 ->
          [mission: "must be at most 500 characters"]

        true ->
          []
      end
    end)
  end

  defp validate_founding_date(changeset) do
    validate_change(changeset, :founding_date, fn _, date ->
      if date do
        today = Date.utc_today()

        cond do
          Date.compare(date, today) == :gt ->
            [founding_date: "cannot be in the future"]

          true ->
            # Organization cannot be founded before 1800
            min_date = ~D[1800-01-01]

            if Date.compare(date, min_date) == :lt do
              [founding_date: "must be after January 1, 1800"]
            else
              []
            end
        end
      else
        []
      end
    end)
  end
end
