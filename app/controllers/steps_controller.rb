class StepsController < ApplicationController
  def index
    @steps = Step.all
    @step
  end

  def new
    @recipe = Recipe.friendly.find(params[:recipe_id])
  end

  def create
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
