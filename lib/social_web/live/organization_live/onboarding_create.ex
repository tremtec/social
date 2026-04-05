defmodule SocialWeb.OrganizationLive.OnboardingCreate do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  alias Social.Organizations
  alias Social.Organizations.Organization

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope} hide_navbar>
      <div class="min-h-screen bg-gradient-to-br from-primary/5 via-base-100 to-secondary/5 py-12">
        <div class="max-w-2xl mx-auto px-4">
          <%!-- Progress Stepper --%>
          <div class="flex items-center justify-center mb-8">
            <div class="flex items-center gap-4">
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-primary text-primary-content flex items-center justify-center text-sm font-bold">
                  1
                </div>
                <span class="text-sm font-medium text-primary">{gettext("Welcome")}</span>
              </div>
              <div class="w-12 h-0.5 bg-primary"></div>
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-primary text-primary-content flex items-center justify-center text-sm font-bold">
                  2
                </div>
                <span class="text-sm font-medium text-primary">{gettext("Create Org")}</span>
              </div>
              <div class="w-12 h-0.5 bg-base-300"></div>
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-base-300 text-base-content/50 flex items-center justify-center text-sm font-bold">
                  3
                </div>
                <span class="text-sm font-medium text-base-content/50">{gettext("Dashboard")}</span>
              </div>
            </div>
          </div>

          <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
            <div class="text-center mb-8">
              <div class="w-20 h-20 mx-auto mb-4 rounded-2xl bg-primary flex items-center justify-center shadow-lg">
                <.icon name="hero-plus" class="w-10 h-10 text-primary-content" />
              </div>
              <h1 class="text-3xl font-bold mb-2">{gettext("Create Your Organization")}</h1>
              <p class="text-base-content/70">
                {gettext("Let's set up your organization. This will only take a few minutes.")}
              </p>
            </div>

            <.form
              for={@form}
              id="create-organization-form"
              phx-change="validate"
              phx-submit="create"
              class="space-y-6"
            >
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <.input
                  field={@form[:name]}
                  type="text"
                  label={gettext("Organization Name")}
                  placeholder={gettext("e.g., Social Foundation")}
                />

                <.input
                  field={@form[:slug]}
                  type="text"
                  label={gettext("URL Slug")}
                  placeholder={gettext("e.g., social-foundation")}
                />
              </div>

              <.input
                field={@form[:cnpj]}
                type="text"
                label={gettext("CNPJ")}
                placeholder={gettext("e.g., 12.345.678/0001-90")}
                id="organization-cnpj"
                phx-hook=".CnpjMask"
              />

              <.input
                field={@form[:description]}
                type="textarea"
                label={gettext("Description")}
                placeholder={gettext("Brief description of your organization")}
              />

              <.input
                field={@form[:mission]}
                type="textarea"
                label={gettext("Mission")}
                placeholder={gettext("Your organization's mission statement")}
              />

              <.input
                field={@form[:founding_date]}
                type="date"
                label={gettext("Founding Date")}
              />

              <div class="flex items-center gap-4 pt-4">
                <.link
                  navigate="/onboarding"
                  class="btn btn-ghost flex-1"
                >
                  <.icon name="hero-arrow-left" class="w-5 h-5 mr-2" />
                  {gettext("Back")}
                </.link>
                <.button
                  type="submit"
                  phx-disable-with={gettext("Creating...")}
                  class="btn btn-primary flex-1"
                >
                  <.icon name="hero-check" class="w-5 h-5 mr-2" />
                  {gettext("Create Organization")}
                </.button>
              </div>
            </.form>
          </div>
        </div>
      </div>
    </Layouts.app>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".CnpjMask">
      export default {
        mounted() {
          this.el.addEventListener("input", e => {
            let value = e.target.value.replace(/\D/g, "");
            
            // Limit to 14 digits
            value = value.substring(0, 14);
            
            // Apply CNPJ mask: XX.XXX.XXX/XXXX-XX
            let formatted = "";
            if (value.length > 0) {
              formatted = value.substring(0, 2);
            }
            if (value.length > 2) {
              formatted += "." + value.substring(2, 5);
            }
            if (value.length > 5) {
              formatted += "." + value.substring(5, 8);
            }
            if (value.length > 8) {
              formatted += "/" + value.substring(8, 12);
            }
            if (value.length > 12) {
              formatted += "-" + value.substring(12, 14);
            }
            
            // Only update if the formatted value is different to avoid cursor jumping
            if (e.target.value !== formatted) {
              e.target.value = formatted;
              // Dispatch input event so LiveView receives the formatted value
              e.target.dispatchEvent(new Event("input", { bubbles: true }));
            }
          });
        }
      }
    </script>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    changeset = Organization.changeset(%Organization{}, %{})

    {:ok,
     socket
     |> assign(:form, to_form(changeset, as: "organization"))}
  end

  @impl true
  def handle_event("validate", %{"organization" => params}, socket) do
    changeset =
      %Organization{}
      |> Organization.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:form, to_form(changeset, as: "organization"))}
  end

  @impl true
  def handle_event("create", %{"organization" => params}, socket) do
    case Organizations.create_organization(socket.assigns.current_scope, params) do
      {:ok, organization} ->
        {:noreply,
         socket
         |> put_flash(:info, gettext("Organization created successfully!"))
         |> push_navigate(to: "/organizations/#{organization.slug}")}

      {:error, changeset} ->
        {:noreply,
         socket
         |> assign(:form, to_form(changeset, as: "organization"))
         |> put_flash(:error, gettext("Please fix the errors below"))}
    end
  end
end
