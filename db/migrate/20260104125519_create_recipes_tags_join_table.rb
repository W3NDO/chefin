class CreateRecipesTagsJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :recipes, :tags
  end
end
