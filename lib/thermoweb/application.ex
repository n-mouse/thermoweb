defmodule Thermoweb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Thermoweb.Router, options: [port: 4001]),
      {Tortoise.Connection, 
        [
          client_id: "esp_front",
          handler: {Tortoise.Handler.Logger, []},
          server: {Tortoise.Transport.Tcp, host: 'test.mosquitto.org', port: 1883},
          subscriptions: [{"parampam/stat", 0}]
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: Thermoweb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
