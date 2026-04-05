defmodule Social.OrganizationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Social.Organizations` context.
  """

  alias Social.AccountsFixtures
  alias Social.Organizations

  # Pre-computed valid CNPJs for testing (computed using standard algorithm)
  # 12.345.678/0001-95 is valid
  # 11.222.333/0001-81 is valid
  # 40.748.602/0001-46 is valid
  @valid_cnpjs [
    "12.345.678/0001-95",
    "11.222.333/0001-81",
    "40.748.602/0001-46"
  ]

  def valid_organization_attributes(attrs \\ %{}) do
    number = System.unique_integer([:positive])
    cnpj = Enum.at(@valid_cnpjs, number |> Integer.mod(3))

    attrs
    |> Enum.into(%{
      name: "Test Organization #{number}",
      slug: "test-org-#{number}",
      cnpj: cnpj,
      description: "This is a test organization description",
      mission: "Our mission is to test things",
      founding_date: ~D[2020-01-15]
    })
    |> Map.merge(attrs)
  end

  def organization_fixture(attrs \\ %{}) do
    scope = AccountsFixtures.user_scope_fixture()

    {:ok, organization} =
      Organizations.create_organization(scope, valid_organization_attributes(attrs))

    organization
  end
end
