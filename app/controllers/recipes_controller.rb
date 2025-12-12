class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipes
  end

  def create
  end

  def show
    @recipe = Recipe.includes(:ingredients, :steps).find(params[:id])
  end

  def update
  end

  def destroy
  end
end
