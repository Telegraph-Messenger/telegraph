defmodule TelegraphWeb.AdminHTML do
  use TelegraphWeb, :html

  embed_templates("admin_html/*")

  # Import the admin function from Layouts
  import TelegraphWeb.Layouts, only: [admin: 1]

  def admin_layout(assigns) do
    ~H"""
    <.admin>
      <%= render_slot(@inner_block) %>
    </.admin>
    """
  end
end
