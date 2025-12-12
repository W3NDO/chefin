class StepsController < ApplicationController
  def index
    @steps = Step.all
    @step
  end

  def create
  end

  def update
  end

  def destroy
  end
end
