class TagsController < ApplicationController
  def index
    @tags = Tag.friendly.all.order(:slug)
  end

  def show
    @tag = Tag.friendly.includes(:recipes).find(params[:id])
    @recipes = @tag.recipes
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
