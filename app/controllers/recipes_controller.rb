class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_recipe, only: %i[ show update update destroy ]
  def index
    @recipes = Recipe.all.reverse
    @recipes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    puts params

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
  end

  def show
    @recipe = Recipe.friendly.includes(:ingredients, :steps).find(params[:id])
    @ingredients = @recipe.ingredients.map { |i| i }

    @steps = @recipe.steps
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :sources, ingredients_attributes: [ :name, :amount, :amount_unit, :alternative ], steps_attributes: [ :step_number, :duration, :duration_unit, :pre_requisite_steps, :instruction ])
  end

  def set_recipe
    @recipe = Recipe.friendly.find(params[:id])
  end
end
