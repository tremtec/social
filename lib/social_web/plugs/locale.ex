defmodule SocialWeb.Plugs.Locale do
  @moduledoc """
  Plug to handle locale detection and setting.

  Supported locales:
  - en (English - default)
  - pt_BR (Portuguese - Brazil)
  """
  import Plug.Conn

  @locales ["en", "pt_BR"]

  def init(opts), do: opts

  def call(conn, _opts) do
    # Detect locale from Accept-Language header
    # This allows the locale to automatically follow browser settings
    locale = detect_locale_from_header(conn)

    # Always set Gettext locale and assign to conn
    Gettext.put_locale(SocialWeb.Gettext, locale)

    IO.puts("Detected HTML: #{locale}")

    conn
    |> assign(:locale, locale)
    |> put_session("locale", locale)
  end

  # Handle both Plug.Conn and LiveView tests
  defp detect_locale_from_header(%Plug.Conn{} = conn) do
    conn
    |> get_req_header("accept-language")
    |> parse_accept_language()
    |> get_supported_locale()
  end

  defp parse_accept_language([]), do: "en"

  defp parse_accept_language([header | _]) do
    header
    |> String.split(",")
    |> Enum.map(&parse_language_tag/1)
    |> Enum.max_by(fn {_, quality} -> quality end, fn -> {"en", 0} end)
    |> elem(0)
  end

  defp parse_language_tag(tag) do
    [lang | rest] = String.split(tag, ";")

    quality =
      case rest do
        [] ->
          1.0

        [q | _] ->
          case Regex.run(~r/q=([0-9.]+)/, q) do
            nil -> 1.0
            [_, q_val] -> String.to_float(q_val)
          end
      end

    {String.trim(lang), quality}
  end

  defp get_supported_locale(locale) when locale in @locales, do: locale

  defp get_supported_locale(locale) do
    case String.starts_with?(locale, "pt") do
      true -> "pt_BR"
      false -> "en"
    end
  end
end
