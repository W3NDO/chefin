class Add < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :user_id, :integer, null: false
  end
end
