defmodule SocialWeb.Hooks.Locale do
  @moduledoc """
  Hook to configure Gettext locale and assign for all LiveViews.

  Reads locale from session and sets it for Gettext and socket assigns.
  The locale is already configured in the plug, but we need to set it
  in the socket for LiveView templates.
  """
  import Phoenix.Component

  @default_locale "pt_BR"

  def on_mount(:set_locale, _params, %{"locale" => locale}, socket) do
    Gettext.put_locale(SocialWeb.Gettext, locale)

    IO.puts("LiveView set locale: #{locale}")

    {:cont, assign(socket, :locale, locale)}
  end

  def on_mount(:set_locale, _params, _session, socket) do
    Gettext.put_locale(SocialWeb.Gettext, @default_locale)
    {:cont, assign(socket, :locale, @default_locale)}
  end
end
