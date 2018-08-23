defmodule Krusty.PageController do
  use Krusty.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
