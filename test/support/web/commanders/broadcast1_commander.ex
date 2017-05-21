defmodule DrabTestApp.Broadcast1Commander do
  @moduledoc false
  
  use Drab.Commander

  onload :page_loaded
  onconnect :connected

  def page_loaded(socket) do
    socket |> Drab.Query.insert("<h3 id='page_loaded_indicator'>Page Loaded</h3>", after: "#begin")
    socket |> Drab.Query.insert("<h5>Drab Broadcast Topic: #{__drab__().broadcasting |> inspect}</h5>", 
      after: "#page_loaded_indicator")
    p = inspect(socket.assigns.__drab_pid)
    pid_string = Regex.named_captures(~r/#PID<(?<pid>.*)>/, p) |> Map.get("pid")
    socket |> Drab.Query.update(:text, set: pid_string, on: "#drab_pid")
  end

  def connected(socket) do
    socket |> Drab.Query.update(:text, set: "", on: "#broadcast_out")
  end

  def broadcast1(socket, _) do
    socket |> update!(:text, set: "Broadcasted Text to same url", on: "#broadcast_out")
  end
end