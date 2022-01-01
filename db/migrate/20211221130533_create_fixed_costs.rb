class CreateFixedCosts < ActiveRecord::Migration[6.0]
  def change
    create_table :fixed_costs do |t|
      t.integer :payment, null: false
      t.integer :monthly_annual, null: false, default: 0
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
