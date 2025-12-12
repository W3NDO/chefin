class AddRecipeIdToSteps < ActiveRecord::Migration[8.0]
  def change
    add_column :steps, :recipe_id, :integer, null: false
    add_column :ingredients, :recipe_id, :integer, null: false
  end
end
