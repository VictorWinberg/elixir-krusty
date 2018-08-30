defmodule Krusty.CookieIngredientView do
    use Krusty.Web, :view
  
    def render("index.json", %{ingredients: ingredients}) do
        %{data: render_many(ingredients, Krusty.CookieIngredientView, "cookie_ingredient.json", as: :ingredient)}
    end
    
    def render("cookie_ingredient.json", %{ingredient: ingredient}) do
        %{
          id: ingredient.id,
          amount: ingredient.amount,
          name: ingredient.ingredient.name
        }
      end
end