defmodule SocialWeb.SocialComponents do
  @moduledoc """
  Social-specific UI components for the Social Tools platform.

  These components complement CoreComponents with domain-specific patterns
  for NPO/ONG management (volunteers, donations, events, etc.).

  ## Usage

  Import in your LiveView:

      alias SocialWeb.SocialComponents

  Then use components:

      <.social_button variant="primary">Save</.social_button>
      <.social_card>Content</.social_card>
  """
  use Phoenix.Component
  use Gettext, backend: SocialWeb.Gettext

  # Import core components for wrapping
  import SocialWeb.CoreComponents

  @doc """
  Button component with multiple variants.

  ## Variants
  - `primary` - Main actions (default)
  - `secondary` - Secondary actions
  - `ghost` - Subtle actions
  - `danger` - Destructive actions
  - `link` - Text links

  ## Sizes
  - `sm` - Small
  - `md` - Medium (default)
  - `lg` - Large

  ## Examples

      <.social_button>Save</.social_button>
      <.social_button variant="secondary" size="lg">Submit</.social_button>
      <.social_button variant="danger" phx-click="delete">Delete</.social_button>
  """
  attr :variant, :string,
    values: ["primary", "secondary", "ghost", "danger", "link"],
    default: "primary"

  attr :size, :string, values: ["sm", "md", "lg"], default: "md"
  attr :class, :any, default: nil
  attr :disabled, :boolean, default: false
  attr :loading, :boolean, default: false
  attr :rest, :global, include: ~w(navigate patch href method download name value)

  slot :inner_block, required: true

  def social_button(assigns) do
    variant_classes = %{
      "primary" => "btn-primary",
      "secondary" => "btn-secondary",
      "ghost" => "btn-ghost",
      "danger" => "btn-error",
      "link" => "btn-link"
    }

    size_classes = %{
      "sm" => "btn-sm",
      "md" => "",
      "lg" => "btn-lg"
    }

    assigns =
      assigns
      |> assign(:variant_class, variant_classes[assigns[:variant] || "primary"])
      |> assign(:size_class, size_classes[assigns[:size] || "md"])
      |> assign(:loading_class, if(assigns[:loading], do: "loading", else: nil))

    ~H"""
    <button
      class={["btn", @variant_class, @size_class, @loading_class, @class]}
      disabled={@disabled or @loading}
      {@rest}
    >
      <span :if={@loading} class="loading loading-spinner loading-sm"></span>
      {render_slot(@inner_block)}
    </button>
    """
  end

  @doc """
  Card component with optional glass effect and hover animation.

  ## Options
  - `glass` - Adds glassmorphism effect
  - `hover` - Adds hover animation
  - `padding` - Custom padding (default: "normal")

  ## Slots
  - `:header` - Card header/title
  - `:footer` - Card footer/actions

  ## Examples

      <.social_card>
        <:header>Title</:header>
        Content
      </.social_card>

      <.social_card glass hover>
        Glass card with hover
      </.social_card>
  """
  attr :class, :any, default: nil
  attr :glass, :boolean, default: false
  attr :hover, :boolean, default: false
  attr :padding, :string, default: "normal"

  slot :inner_block, required: true
  slot :header
  slot :footer

  def social_card(assigns) do
    padding_classes = %{
      "none" => "",
      "small" => "p-3",
      "normal" => "p-6",
      "large" => "p-8"
    }

    assigns =
      assign(assigns, :padding_class, padding_classes[assigns[:padding] || "normal"])

    ~H"""
    <div class={[
      "card",
      "bg-base-200",
      "shadow-md",
      @glass && "glass",
      @hover && "hover:scale-[1.02] transition-transform duration-200",
      @padding_class,
      @class
    ]}>
      <div :if={@header != []} class="card-body">
        <h2 class="card-title">
          {render_slot(@header)}
        </h2>
        {render_slot(@inner_block)}
      </div>
      <div :if={@header == []} class="card-body">
        {render_slot(@inner_block)}
      </div>
      <div :if={@footer != []} class="card-footer">
        {render_slot(@footer)}
      </div>
    </div>
    """
  end

  @doc """
  Badge component for status indicators.

  ## Variants
  - `primary`, `secondary`, `accent`
  - `success`, `warning`, `error`, `info`
  - `ghost`

  ## Examples

      <.social_badge variant="success">Active</.social_badge>
      <.social_badge variant="warning">Pending</.social_badge>
      <.social_badge variant="error">Failed</.social_badge>
  """
  attr :variant, :string,
    values: ["primary", "secondary", "accent", "success", "warning", "error", "info", "ghost"],
    default: "primary"

  attr :size, :string, values: ["sm", "md", "lg"], default: "md"
  attr :class, :any, default: nil

  slot :inner_block, required: true

  def social_badge(assigns) do
    size_classes = %{
      "sm" => "badge-sm",
      "md" => "",
      "lg" => "badge-lg"
    }

    assigns = assign(assigns, :size_class, size_classes[assigns[:size] || "md"])

    ~H"""
    <span class={["badge", "badge-#{@variant}", @size_class, @class]}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  @doc """
  Avatar component with image or initials fallback.

  ## Options
  - `src` - Image URL
  - `name` - Name for initials fallback
  - `size` - Size (xs, sm, md, lg, xl)
  - `status` - Status indicator (online, offline, busy, away)

  ## Examples

      <.social_avatar src={@user.avatar_url} />
      <.social_avatar name="John Doe" size="lg" />
      <.social_avatar src={@org.logo} status="online" />
  """
  attr :src, :string, default: nil
  attr :name, :string, default: nil
  attr :size, :string, values: ["xs", "sm", "md", "lg", "xl"], default: "md"
  attr :status, :string, values: [nil, "online", "offline", "busy", "away"], default: nil
  attr :class, :any, default: nil

  def social_avatar(assigns) do
    size_classes = %{
      "xs" => "w-6 h-6",
      "sm" => "w-8 h-8",
      "md" => "w-10 h-10",
      "lg" => "w-12 h-12",
      "xl" => "w-16 h-16"
    }

    status_colors = %{
      "online" => "bg-success",
      "offline" => "bg-base-300",
      "busy" => "bg-error",
      "away" => "bg-warning"
    }

    initials =
      if assigns[:name] do
        assigns[:name]
        |> String.split()
        |> Enum.map(&String.first/1)
        |> Enum.take(2)
        |> Enum.join("")
        |> String.upcase()
      else
        nil
      end

    assigns =
      assign(assigns, :size_class, size_classes[assigns[:size] || "md"])
      |> assign(:status_color, if(assigns[:status], do: status_colors[assigns[:status]]))
      |> assign(:initials, initials)

    ~H"""
    <div class="avatar placeholder">
      <div class={[@size_class, "rounded-full", "bg-base-300", @class]}>
        <img :if={@src} src={@src} alt={@name} />
        <span :if={!@src && @initials} class="text-xs">
          {@initials}
        </span>
        <span :if={!@src && !@initials} class="text-base-content/50">
          <.icon name="hero-user" class="w-1/2 h-1/2" />
        </span>
      </div>
      <span
        :if={@status}
        class={[
          "absolute bottom-0 right-0 w-3 h-3 rounded-full border-2 border-base-100",
          @status_color
        ]}
      >
      </span>
    </div>
    """
  end

  @doc """
  Empty state component for lists with no content.

  ## Options
  - `icon` - Heroicon name
  - `title` - Title text
  - `description` - Optional description
  - `action` - Optional action button text
  - `action_click` - Optional phx-click event

  ## Examples

      <.social_empty_state
        icon="hero-inbox"
        title="No items yet"
        description="Create your first item"
      />
  """
  attr :icon, :string, default: "hero-inbox"
  attr :title, :string, required: true
  attr :description, :string, default: nil
  attr :action, :string, default: nil
  attr :action_variant, :string, default: "primary"
  attr :action_click, :string, default: nil
  attr :class, :any, default: nil

  slot :inner_block

  def social_empty_state(assigns) do
    ~H"""
    <div class={["flex flex-col items-center justify-center py-12 text-center", @class]}>
      <div class="bg-base-300 rounded-full p-4 mb-4">
        <.icon name={assigns[:icon] || "hero-inbox"} class="w-12 h-12 text-base-content/50" />
      </div>
      <h3 class="text-lg font-semibold text-base-content mb-2">
        {@title}
      </h3>
      <p :if={assigns[:description]} class="text-base-content/70 mb-6 max-w-sm">
        {assigns[:description]}
      </p>
      <div :if={assigns[:action]}>
        <.social_button
          variant={assigns[:action_variant] || "primary"}
          phx-click={assigns[:action_click]}
        >
          {assigns[:action]}
        </.social_button>
      </div>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Stat component for displaying metrics.

  ## Options
  - `title` - Stat title
  - `value` - Stat value
  - `icon` - Optional Heroicon
  - `trend` - Optional trend (:up, :down)
  - `trend_value` - Trend percentage/value
  - `trend_positive` - Is positive trend good? (default: true)

  ## Examples

      <.social_stat
        title="Total Volunteers"
        value={123}
        icon="hero-user-group"
      />
  """
  attr :title, :string, required: true
  attr :value, :any, required: true
  attr :icon, :string, default: nil
  attr :trend, :string, values: [nil, "up", "down"], default: nil
  attr :trend_value, :string, default: nil
  attr :trend_positive, :boolean, default: true
  attr :class, :any, default: nil

  slot :inner_block

  def social_stat(assigns) do
    trend_class =
      cond do
        assigns[:trend_positive] and assigns[:trend] == "up" -> "text-success"
        assigns[:trend_positive] and assigns[:trend] == "down" -> "text-error"
        not assigns[:trend_positive] and assigns[:trend] == "up" -> "text-error"
        not assigns[:trend_positive] and assigns[:trend] == "down" -> "text-success"
        true -> ""
      end

    assigns = assign(assigns, :trend_class, trend_class)

    ~H"""
    <div class={["stat bg-base-200 rounded-box p-4", @class]}>
      <div :if={assigns[:icon]} class="flex items-center gap-2 mb-2">
        <.icon name={assigns[:icon]} class="w-5 h-5 text-primary" />
        <span class="text-sm text-base-content/70">{@title}</span>
      </div>
      <div :if={!assigns[:icon]} class="text-sm text-base-content/70 mb-1">
        {@title}
      </div>
      <div class="stat-value text-2xl font-bold">
        {@value}
      </div>
      <div
        :if={assigns[:trend] && assigns[:trend_value]}
        class={["text-sm mt-1 flex items-center gap-1", @trend_class]}
      >
        <.icon
          :if={assigns[:trend] == "up"}
          name="hero-arrow-trending-up"
          class="w-4 h-4"
        />
        <.icon
          :if={assigns[:trend] == "down"}
          name="hero-arrow-trending-down"
          class="w-4 h-4"
        />
        <span>{assigns[:trend_value]}</span>
      </div>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Alert component for notifications.

  ## Variants
  - `success` - Positive feedback
  - `warning` - Caution messages
  - `error` - Error messages
  - `info` - Information

  ## Examples

      <.social_alert variant="success" title="Success!">
        Operation completed.
      </.social_alert>
  """
  attr :variant, :string, values: ["success", "warning", "error", "info"], default: "info"
  attr :title, :string, default: nil
  attr :class, :any, default: nil

  slot :inner_block

  def social_alert(assigns) do
    icon_names = %{
      "success" => "hero-check-circle",
      "warning" => "hero-exclamation-triangle",
      "error" => "hero-x-circle",
      "info" => "hero-information-circle"
    }

    assigns = assign(assigns, :icon_name, icon_names[assigns[:variant] || "info"])

    ~H"""
    <div role="alert" class={["alert", "alert-#{@variant}", @class]}>
      <.icon name={@icon_name} class="w-6 h-6 shrink-0" />
      <div>
        <h3 :if={assigns[:title]} class="font-semibold">{assigns[:title]}</h3>
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  @doc """
  Modal component for dialogs.

  ## Options
  - `id` - Unique modal ID (required)
  - `title` - Modal title
  - `on_confirm` - JS to execute on confirm

  ## Slots
  - `:inner_block` - Modal content
  - `:cancel` - Cancel button text
  - `:confirm` - Confirm button text

  ## Examples

      <.social_modal id="confirm" title="Confirm" on_confirm={JS.push("delete")}>
        <p>Are you sure?</p>
        <:cancel>Cancel</:cancel>
        <:confirm>Delete</:confirm>
      </.social_modal>
  """
  attr :id, :string, required: true
  attr :title, :string, default: nil
  attr :on_confirm, :any, default: nil
  attr :confirm_variant, :string, default: "primary"
  attr :class, :any, default: nil

  slot :inner_block, required: true
  slot :cancel
  slot :confirm

  def social_modal(assigns) do
    ~H"""
    <dialog id={@id} class="modal">
      <div class="modal-box">
        <h3 :if={assigns[:title]} class="font-bold text-lg mb-4">
          {assigns[:title]}
        </h3>
        <div class="py-4">
          {render_slot(@inner_block)}
        </div>
        <div class="modal-action">
          <form method="dialog">
            <button class="btn btn-ghost">
              {render_slot(@cancel) || gettext("Cancel")}
            </button>
          </form>
          <button
            :if={assigns[:on_confirm]}
            class={[
              "btn btn-#{assigns[:confirm_variant] || "primary"}",
              assigns[:confirm_variant] == "error" && "btn-error"
            ]}
            phx-click={assigns[:on_confirm]}
          >
            {render_slot(@confirm) || gettext("Confirm")}
          </button>
        </div>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>
    """
  end

  @doc """
  Navigation item for sidebar/menu.

  ## Options
  - `active` - Is current page active?
  - `icon` - Heroicon name
  - `label` - Navigation label (uses slot if not provided)

  ## Examples

      <.social_nav_item icon="hero-home" label="Home" navigate={~p"/"} />
      <.social_nav_item icon="hero-users" active>Volunteers</.social_nav_item>
  """
  attr :active, :boolean, default: false
  attr :icon, :string, default: nil
  attr :class, :any, default: nil
  attr :rest, :global, include: ~w(navigate patch href)

  slot :inner_block, required: true

  def social_nav_item(assigns) do
    ~H"""
    <.link
      class={[
        "flex items-center gap-3 px-4 py-3 rounded-lg transition-colors",
        @active && "bg-primary text-primary-content",
        !@active && "hover:bg-base-200",
        @class
      ]}
      {@rest}
    >
      <.icon :if={assigns[:icon]} name={assigns[:icon]} class="w-5 h-5" />
      <span class="font-medium">
        {render_slot(@inner_block)}
      </span>
    </.link>
    """
  end
end
