class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :name, :string
    add_column :users, :profile, :text
    add_column :users, :image, :string
    add_column :users, :adult_number, :integer, null: false, default: 1
    add_column :users, :child_number, :integer, null: false, default: 0
  end
end
