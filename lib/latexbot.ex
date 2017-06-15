defmodule LatexBot do
  @moduledoc """
  Documentation for LatexBot.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LatexBot.hello
      :world

  """
  def hello do
    :world
  end

  defp send_message(msg, embed \\ %{}, ch, conn), do: DiscordEx.RestClient.Resources.Channel.send_message conn, ch, %{content: msg, embed: embed}
  defp delete_message(msg, ch, conn), do: DiscordEx.RestClient.Resources.Channel.delete_message conn, ch, msg

  defp _greet, do: ["Hello!", "Hi!", "Hey!", "Howdy!", "Hiya!", "HeyHi!", "Greetings!"]
  def greet(conn, channel), do: _greet() |> Enum.random |> send_message(channel, conn) |> IO.inspect


  defp show(:author, conn, ch) do
    send_message """
    I was created by the one and only <@249991058132434945>!
    Check out more of his mediocre code @ https://github.com/ShadowfeindX
    """, ch, conn
  end

  defp show(:source, conn, ch) do
    send_message """
    You can find my source in our community repository!
    https://github.com/TumblrCommunity/latexbot
    """, ch, conn
  end

  defp show(:help, conn, ch) do
    send_message "In progress...", ch, conn
  end

  def handle_event({:message_create, payload}, state) do
    client = "<@#{state[:client_id]}>"
    show = fn x -> show x, state[:rest_client], payload[:data]["channel_id"] end
    message = payload
      |> DiscordEx.Client.Helpers.MessageHelper.msg_command_parse("#{client}")
      |> (fn {x,y} -> {String.trim(x), y} end).()
    case message do
      {"help", _} -> show.(:help)
      {"source", _} -> show.(:source)
      {"author", _} -> show.(:author)
      {_unknown, _command} -> show.(:help)
    end |> IO.inspect
    {:ok, state}
  end
  def handle_event({event, payload}, state) do
    IO.puts """
      Received Event: #{event}
      With Payload: #{inspect payload}
      """
    {:ok, state}
  end

end
