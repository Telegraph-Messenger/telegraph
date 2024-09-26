defmodule TelegraphWeb.Layouts do
  use TelegraphWeb, :html

  embed_templates("layouts/*")

  def app(assigns) do
    ~H"""
    <.html>
      <.app_layout>
        <%= @inner_content %>
      </.app_layout>
    </.html>
    """
  end

  def admin(assigns) do
    ~H"""
    <.html>
      <.admin_layout>
        <%= @inner_content %>
      </.admin_layout>
    </.html>
    """
  end

  slot(:inner_block, required: true)

  def app_layout(assigns) do
    ~H"""
    <header class="px-4 sm:px-6 lg:px-8">
      <!-- Your app header content -->
    </header>
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <div class="mx-auto max-w-2xl">
        <%= render_slot(@inner_block) %>
      </div>
    </main>
    """
  end

  slot(:inner_block, required: true)

  def admin_layout(assigns) do
    ~H"""
    <div class="drawer lg:drawer-open">
      <!-- Your admin layout content -->
      <main class="p-4">
        <%= render_slot(@inner_block) %>
      </main>
    </div>
    """
  end

  slot(:inner_block, required: true)

  def html(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en" class="[scrollbar-gutter:stable]">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="csrf-token" content={get_csrf_token()} />
        <.live_title suffix=" · Phoenix Framework">
          <%= assigns[:page_title] || "Telegraph" %>
        </.live_title>
        <link phx-track-static rel="stylesheet" href={~p"/assets/app.css"} />
        <script defer phx-track-static type="text/javascript" src={~p"/assets/app.js"}>
        </script>
      </head>
      <body class="bg-white antialiased">
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end
end
