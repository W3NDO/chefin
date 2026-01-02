class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.float :amount, null: false
      t.float :temp, null: true, default: "N/A"
      t.string :amount_unit, null: false
      t.string :temp_unit, null: true, default: "N/A"
      t.string :alternative, null: true, default: "N/A"

      t.timestamps
    end
  end
end
