Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.3"}
])

defmodule Shortcut do
  @allegro_id "4"
  @api_version "v3"
  @api_url "https://api.app.shortcut.com/api/#{@api_version}"
  @shortcut_token System.fetch_env!("SHORTCUT_TOKEN")
  # Allegro id == 4
  @project_id to_string(System.get_env("SHORTCUT_PROJECT", @allegro_id))
  @headers %{"content-type" => "application/json", "shortcut-token" => @shortcut_token}

  def new do
    IO.puts("new requires at least a name argument. Usage: shortcut new title [description]")
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

    IO.write(post("stories", body))
  end

  def projects do
    IO.puts(get("projects"))
  end

  def whoami do
    IO.puts(get("member"))
  end

  def labels do
    IO.puts(get("labels"))
  end

  defp post(endpoint, body) do
    HTTPoison.post("#{@api_url}/#{endpoint}", Jason.encode!(body), @headers)
    |> normalize_response()
  end

  defp get(endpoint) do
    HTTPoison.get("#{@api_url}/#{endpoint}", @headers)
    |> normalize_response()
  end

  defp normalize_response({:ok, %{body: body}}), do: body
  defp normalize_response({:error, error}), do: error
end

if match?([], System.argv()) do
  IO.puts("""
  shortcut - commandline Shortcut API Integration
  Usage:
  new title [description]         Create new story with title and optional description
  projects                        List all projects. Use with jq for pretty output, i.e. shorcut projects | jq '.[] | {name: .name, id: .id}'
  whoami                          List info of the authenticated shortcut member from SHORTCUT_TOKEN
  labels                          List labels and their attributes
  """)

  Process.exit(self(), 1)
end

[action | args] = System.argv()
apply(Shortcut, String.to_atom(action), args)
