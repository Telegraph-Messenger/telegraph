# lib/telegraph_web/live/counter_live.ex
defmodule TelegraphWeb.CounterLive do
  use TelegraphWeb, :live_view

  def mount(_params, _session, socket) do
    # Initialize the count
    {:ok, assign(socket, count: 0)}
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("decrement", _, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Count: <%= @count %></h1> <span> </span>
      <button phx-click="decrement">-</button>
      <button phx-click="increment">+</button>
    </div>
    """
  end
end
