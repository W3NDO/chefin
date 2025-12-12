class UpdateNameInStepModel < ActiveRecord::Migration[8.0]
  def change
    remove_column :steps, :intruction
    add_column :steps, :instruction, :text, null: false
  end
end
