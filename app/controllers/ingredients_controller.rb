class IngredientsController < ApplicationController
  before_action authenticate_user!, except: [ :index ]
  def index
    @ingredients = Ingredient.all
    @ingredients
  end

  def create
  end

  def update
  end

  def destroy
  end
end
