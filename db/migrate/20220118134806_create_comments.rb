class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.integer :send_user

      t.timestamps
    end
  end
end
