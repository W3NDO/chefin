class IngredientsController < ApplicationController
  before_action :authenticate_user!
  def index
    @ingredients = Ingredient.all
    @ingredients
  end

  def create
  end

  def new
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
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
end
