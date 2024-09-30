defmodule TelegraphWeb.Live.CounterHeaderComponent do
  use TelegraphWeb, :live_component

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <span>Count: <%= @count %></span>
    """
  end
end
