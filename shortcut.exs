Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.3"}
])

defmodule Shortcut do
  @api_version "v3"
  @api_url "https://api.app.shortcut.com/api/#{@api_version}"
  @shortcut_token System.fetch_env!("SHORTCUT_TOKEN")
  @headers %{"content-type" => "application/json", "shortcut-token", @shortcut_token}

  def new(name) do
    new(name, "")
  end

  def new(name, description) do
    body = %{
      name: name,
      description: description
    }

    case request("stories", body) do
      {:ok, story} ->
        IO.inspect story

      {:error, error} ->
        IO.inspect error
    end
  end

  def new(_) do
    raise "new requires at least a name argument. Usage: shortcut new 'Card Name'"
  end

  defp request(endpoint) do
    HTTPoision.
  end
end

unless [action | args] = System.argv, do: raise("Requires at least one argument. Example: shortcut new")
# We want at least 2 args
IO.inspect action

apply(Shortcut, String.to_atom(action), args)