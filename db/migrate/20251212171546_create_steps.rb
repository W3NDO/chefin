class CreateSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :steps do |t|
      t.text :intruction, null: false
      t.integer :step_number, null: false
      t.integer :duration, null: true, default: "N/A"
      t.string :duration_unit, null: true, default: "N/A"
      t.integer :pre_requisite_steps, null: true, default: "N/A"

      t.timestamps
    end
  end
end
