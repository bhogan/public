class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :string
    add_column :users, :boolean, :string
  end
end
