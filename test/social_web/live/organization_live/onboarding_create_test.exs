defmodule SocialWeb.OrganizationLive.OnboardingCreateTest do
  use SocialWeb.ConnCase

  import Phoenix.LiveViewTest
  import Social.AccountsFixtures

  # Valid CNPJs for testing
  @valid_cnpj "12.345.678/0001-95"

  describe "Onboarding create organization page" do
    test "renders create organization form", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, _lv, html} = live(conn, "/onboarding/create-organization")

      assert html =~ "Create Your Organization"
      assert html =~ "Organization Name"
      assert html =~ "URL Slug"
      assert html =~ "CNPJ"
      assert html =~ "Description"
      assert html =~ "Mission"
      assert html =~ "Founding Date"
      assert html =~ "Create Organization"
    end

    test "redirects to login if not authenticated", %{conn: conn} do
      assert {:error, {:redirect, %{to: "/users/log-in"}}} =
               live(conn, "/onboarding/create-organization")
    end

    test "shows error for invalid slug format", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, lv, _html} = live(conn, "/onboarding/create-organization")

      result =
        lv
        |> form("#create-organization-form",
          organization: %{
            "name" => "Test Org",
            "slug" => "Invalid Slug With Spaces",
            "cnpj" => @valid_cnpj,
            "description" => "A valid description for testing",
            "mission" => "A valid mission for testing",
            "founding_date" => "2020-01-15"
          }
        )
        |> render_change()

      assert result =~ "must contain only lowercase letters"
    end

    test "shows error for invalid CNPJ format", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, lv, _html} = live(conn, "/onboarding/create-organization")

      result =
        lv
        |> form("#create-organization-form",
          organization: %{
            "name" => "Test Org",
            "slug" => "test-org",
            "cnpj" => "12345",
            "description" => "A valid description for testing",
            "mission" => "A valid mission for testing",
            "founding_date" => "2020-01-15"
          }
        )
        |> render_change()

      assert result =~ "must be a valid CNPJ"
    end

    test "shows error for future founding date", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, lv, _html} = live(conn, "/onboarding/create-organization")

      result =
        lv
        |> form("#create-organization-form",
          organization: %{
            "name" => "Test Org",
            "slug" => "test-org",
            "cnpj" => @valid_cnpj,
            "description" => "A valid description for testing",
            "mission" => "A valid mission for testing",
            "founding_date" => "2099-01-15"
          }
        )
        |> render_change()

      assert result =~ "cannot be in the future"
    end

    test "shows error for too short description", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, lv, _html} = live(conn, "/onboarding/create-organization")

      result =
        lv
        |> form("#create-organization-form",
          organization: %{
            "name" => "Test Org",
            "slug" => "test-org",
            "cnpj" => @valid_cnpj,
            "description" => "Short",
            "mission" => "A valid mission for testing",
            "founding_date" => "2020-01-15"
          }
        )
        |> render_change()

      assert result =~ "must be at least 10 characters"
    end

    test "shows error for too short mission", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, lv, _html} = live(conn, "/onboarding/create-organization")

      result =
        lv
        |> form("#create-organization-form",
          organization: %{
            "name" => "Test Org",
            "slug" => "test-org",
            "cnpj" => @valid_cnpj,
            "description" => "A valid description for testing",
            "mission" => "Short",
            "founding_date" => "2020-01-15"
          }
        )
        |> render_change()

      assert result =~ "must be at least 10 characters"
    end

    test "shows error for slug starting with hyphen", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      {:ok, lv, _html} = live(conn, "/onboarding/create-organization")

      result =
        lv
        |> form("#create-organization-form",
          organization: %{
            "name" => "Test Org",
            "slug" => "-test-org",
            "cnpj" => @valid_cnpj,
            "description" => "A valid description for testing",
            "mission" => "A valid mission for testing",
            "founding_date" => "2020-01-15"
          }
        )
        |> render_change()

      assert result =~ "must contain only lowercase letters"
    end
  end
end
