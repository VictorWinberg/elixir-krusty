defmodule Krusty.CookieView do
  use Krusty.Web, :view

  def render("index.json", %{cookies: cookies}) do
    %{data: render_many(cookies, Krusty.CookieView, "cookie.json")}
  end

  def render("show.json", %{cookie: cookie}) do
    %{data: render_one(cookie, Krusty.CookieView, "cookie.json")}
  end

  def render("cookie.json", %{cookie: cookie}) do
    %{id: cookie.id,
      name: cookie.name}
  end
end
