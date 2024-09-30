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

  def handle_event("make_admin", %{"id" => id}, socket) do
    make_or_demote_admin(id, true, socket)
  end

  def handle_event("demote_admin", %{"id" => id}, socket) do
    make_or_demote_admin(id, false, socket)
  end

  defp make_or_demote_admin(id, is_admin, socket) do
    user = Accounts.get_user!(id)
    current_user = socket.assigns.current_user

    if is_admin && user.id == current_user.id do
      {:noreply, put_flash(socket, :error, "You cannot promote yourself.")}
    else
      case Accounts.update_user(user, %{is_admin: is_admin}) do
        {:ok, _user} ->
          {:noreply,
           socket
           |> put_flash(
             :info,
             "User has been #{if(is_admin, do: "promoted to", else: "demoted from")} admin."
           )
           |> assign(users: Accounts.list_users())}

        {:error, _changeset} ->
          {:noreply, put_flash(socket, :error, "Failed to update user.")}
      end
    end
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
