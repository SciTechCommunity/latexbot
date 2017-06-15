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

  def handle_event({event, payload}, state) do
    IO.puts """
      Received Event: #{event}
      With Payload: #{inspect payload}
      """
    {:ok, state}
  end

end
