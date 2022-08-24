defmodule Mongo.App do
  @moduledoc false

  def start(_type, _args) do
    children = [
      %{id: Mongo.IdServer, start: {Mongo.IdServer, :start_link, []}, type: :worker},
      %{id: Mongo.PBKDF2Cache, start: {Mongo.PBKDF2Cache, :start_link, []}, type: :worker},
      %{id: :gen_event, start: {:gen_event, :start_link, [local: Mongo.Events]}, type: :worker}
    ]

    opts = [strategy: :one_for_one, name: Mongo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
