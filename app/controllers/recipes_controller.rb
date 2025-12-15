class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
    @recipes = Recipe.all.reverse
    @recipes
  end

  def create
  end

  def show
    @recipe = Recipe.includes(:ingredients, :steps).find(params[:id])
    @ingredients = @recipe.ingredients.map { |i| i }

    @steps = @recipe.steps
  end

  def update
  end

  def destroy
  end
end
