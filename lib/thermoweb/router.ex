defmodule Thermoweb.Router do
    use Plug.Router

    plug Plug.Static,
        at: "/",
        from: :thermoweb

    plug Plug.Parsers, parsers: [:json],
                   pass: ["text/*"],
                   json_decoder: Jason
    
    @template_dir "lib/thermoweb/templates"

    plug :match
    plug :dispatch

    get "/" do
        render(conn, "index.html")
    end

    post "/send" do
        values = Enum.join(IO.inspect(conn.params["values"]), ",")
        Tortoise.publish("esp_front", "parampam/pam", values, qos: 0)
        {:ok, json} = Jason.encode(%{status: "ok"})
        send_resp(conn, 200, json) 
    end

    defp render(%{status: status} = conn, template, assigns \\ []) do
        body =
        @template_dir
        |> Path.join(template)
        |> String.replace_suffix(".html", ".html.eex")
        |> EEx.eval_file(assigns)

        send_resp(conn, (status || 200), body)
    end
end
