defmodule TelegraphWeb.Layouts do
  use TelegraphWeb, :html

  embed_templates("layouts/*")

  def admin(assigns) do
    assigns = assign(assigns, :active_page, Map.get(assigns, :active_page, :dashboard))

    ~H"""
    <div class="drawer lg:drawer-open">
      <input id="my-drawer-2" type="checkbox" class="drawer-toggle" />
      <div class="drawer-content flex flex-col">
        <div class="navbar bg-base-100">
          <div class="flex-none lg:hidden">
            <label for="my-drawer-2" class="btn btn-square btn-ghost">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-6 h-6 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
            </label>
          </div>
          <div class="flex-1">
            <a class="btn btn-ghost normal-case text-xl">Telegraph Admin</a>
          </div>
        </div>
        <main class="p-4">
          <.flash_group flash={@flash} />
          <%= @inner_content %>
        </main>
      </div>
      <div class="drawer-side">
        <label for="my-drawer-2" class="drawer-overlay"></label>
        <ul class="menu p-4 w-80 h-full bg-base-200 text-base-content">
          <li><.link navigate={~p"/admin"} class={"btn btn-ghost #{@active_page == :dashboard && "btn-active"}"}>Dashboard</.link></li>
          <li><.link navigate={~p"/admin/users"} class={"btn btn-ghost #{@active_page == :users && "btn-active"}"}>Users</.link></li>
        </ul>
      </div>
    </div>
    """
  end
end
