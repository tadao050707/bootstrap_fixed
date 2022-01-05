class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :cat_name, null: false

      t.timestamps
    end
    add_index :categories, [:cat_name], unique: true
    add_reference :categories, :user, foreign_key: true
    add_reference :categories, :fixed_cost, foreign_key: true
  end
end
