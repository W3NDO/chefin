class HomeController < ApplicationController
  def index
    @sample_recipe = Recipe.friendly.includes(:tags).all.sample
  end
end
