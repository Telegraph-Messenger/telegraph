defmodule TelegraphWeb.Live.AdminUserEditLive do
  use TelegraphWeb, :live_view
  alias Telegraph.Accounts

  on_mount({TelegraphWeb.UserAuth, :mount_current_user})

  def mount(%{"id" => id}, _session, socket) do
    if socket.assigns.current_user.is_admin do
      user = Accounts.get_user!(id)
      changeset = Accounts.change_user(user)

      {:ok,
       socket
       |> assign(user: user)
       |> assign(changeset: changeset)
       |> assign(active_page: :users), layout: {TelegraphWeb.Layouts, :admin}}
    else
      # Redirect or show an error
      {:noreply,
       socket
       |> put_flash(:error, "You are not authorized to access this page.")
       |> push_redirect(to: "/")}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Accounts.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.update_user(socket.assigns.user, user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_redirect(to: ~p"/admin/users")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <h1>Edit User</h1>

    <.simple_form
      for={@changeset}
      id="user-form"
      phx-change="validate"
      phx-submit="save"
    >
      <.input field={@changeset[:email]} type="email" label="Email" required />
      <.input field={@changeset[:is_admin]} type="checkbox" label="Admin?" />
      <:actions>
        <button class="btn btn-primary" type="submit">Save</button>
      </:actions>
    </.simple_form>

    <.link navigate={~p"/admin/users"} class="btn btn-secondary mt-4">Back to Users</.link>
    """
  end
end
