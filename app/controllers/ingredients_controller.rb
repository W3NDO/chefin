class IngredientsController < ApplicationController
  before_action :authenticate_user!
  def index
    @ingredients = Ingredient.all
    @ingredients
  end



  def new
    @recipe = Recipe.friendly.find(params[:recipe_id])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @ingredient.recipe = @recipe

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to new_recipe_ingredient_url(recipe_id: @recipe), notice: "Ingredient for #{@recipe.name} was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ingredients = Ingredient.find(params[:id])
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
  rescue ActiveRecord::RecordNotFound
    task = Task.new(id: params[:id])
  ensure
    respond_to do |format|
      format.turbo_stream
    end
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :amount_unit, :alternative)
  end
end
