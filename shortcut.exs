api_url="https://api.app.shortcut.com"
api_token = System.fetch_env!("SHORTCUT_TOKEN")
Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.3"}
])

Jason.encode!(%{})
|> IO.inspect()
System.get_env("HOST")
|> IO.inspect()
