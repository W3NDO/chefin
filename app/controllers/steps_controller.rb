class StepsController < ApplicationController
  def index
    @steps = Step.all
    @step
  end

  def new
    @recipe = Recipe.friendly.includes(:steps).find(params[:recipe_id])
    @step_number = @recipe.steps.size
  end

  def create
    @step = Step.new(step_params)
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @step.recipe = @recipe

    respond_to do |format|
      if @step.save
        format.html { redirect_to new_recipe_step_url(recipe_id: @recipe), notice: "Step for #{@recipe.name} was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  private
  def step_params
    params.require(:step).permit(:step_number, :duration, :duration_unit, :pre_requisite_steps, :instruction)
  end
end
