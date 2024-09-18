defmodule TelegraphWeb.PageController do
  use TelegraphWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: {TelegraphWeb.Layouts, :app})
  end
end
