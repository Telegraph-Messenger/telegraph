defmodule TelegraphWeb.Live.AdminUsersLive do
  use TelegraphWeb, :live_view
  alias Telegraph.Accounts

  on_mount({TelegraphWeb.UserAuth, :mount_current_user})

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       users: Accounts.list_users(),
       active_page: :users
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
    <h1>Admin Users</h1>

    <table class="table w-full">
      <thead>
        <tr>
          <th>ID</th>
          <th>Email</th>
          <th>Admin?</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <%= for user <- @users do %>
          <tr class={if user.id == @current_user.id, do: "bg-accent text-accent-content", else: ""}>
            <td><%= user.id %></td>
            <td><%= user.email %></td>
            <td><%= if user.is_admin, do: "Yes", else: "No" %></td>
            <td>
              <%= if user.is_admin do %>
                <%= if user.id != @current_user.id do %>
                  <button phx-click="demote_admin" phx-value-id={user.id} data-confirm="Are you sure you want to demote this admin?" class="btn btn-sm btn-error">Demote Admin</button>
                <% end %>
              <% else %>
                <button phx-click="make_admin" phx-value-id={user.id} data-confirm="Are you sure you want to promote this user?" class="btn btn-sm btn-success">Make Admin</button>
              <% end %>
            </td>
          </tr>
        <% end %>
      </tbody>
    </table>

    <.link navigate={~p"/admin"} class="btn btn-primary mt-4">Back to Admin Dashboard</.link>
    """
  end
end
