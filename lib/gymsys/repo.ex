defmodule Gymsys.Repo do
  use Ecto.Repo,
    otp_app: :gymsys,
    adapter: Ecto.Adapters.Postgres
end
