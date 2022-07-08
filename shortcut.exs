Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.3"}
])

defmodule Shortcut do
  @api_version "v3"
  @api_url "https://api.app.shortcut.com/api/#{@api_version}"
  @shortcut_token System.fetch_env!("SHORTCUT_TOKEN")
  @project_id System.fetch_env("SHORTCUT_PROJECT") || 4 # Allegro id == 4
  @headers %{"content-type" => "application/json", "shortcut-token" => @shortcut_token}

  def new([]) do
    raise "new requires at least a name argument. Usage: shortcut new 'Card Name'"
  end

  def new(name) do
    new(name, "")
  end

  def new(name, description) do
    body = %{
      name: name,
      description: description,
      project_id: @project_id
    }

    case post("stories", body) do
      {:ok, story} ->
        IO.inspect story

      {:error, error} ->
        IO.inspect error
    end
  end

  def projects do
    case get("projects") do
      {:ok, %{body: body}} ->
        IO.write(body)

      {:error, error} ->
        IO.inspect error
    end
  end

  defp post(endpoint, body) do
    HTTPoison.post("#{@api_url}/#{endpoint}", Jason.encode!(body), @headers)
  end

  defp get(endpoint) do
    HTTPoison.get("#{@api_url}/#{endpoint}", @headers)
  end
end

unless [action | args] = System.argv, do: raise("Requires at least one argument. Example: shortcut new")

apply(Shortcut, String.to_atom(action), args)
