defmodule Telegraph.Repo do
  use Ecto.Repo,
    otp_app: :telegraph,
    adapter: Ecto.Adapters.Postgres
end
