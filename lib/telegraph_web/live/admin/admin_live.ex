defmodule TelegraphWeb.Live.AdminLive do
  use TelegraphWeb, :live_view
  alias Telegraph.Accounts

  on_mount({TelegraphWeb.UserAuth, :mount_current_user})

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       message: "Welcome to the Admin Dashboard",
       active_page: :dashboard,
       users: Accounts.list_users()
     ), layout: {TelegraphWeb.Layouts, :admin}}
  end

  def render(assigns) do
    ~H"""
    <h1><%= @message %></h1>

    <.link navigate={~p"/admin/users"}>View Users</.link>

    <%= if @live_action == :users do %>
      <%= live_render(
        @socket,
        TelegraphWeb.Live.AdminUsersLive,
        session: %{"users" => @users, "active_page" => assigns.active_page}
      ) %>
    <% end %>
    """
  end
end
