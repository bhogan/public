class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :contest_creator, :boolean
    add_column :users, :is_banned, :boolean
    add_column :users, :chat_url, :string
  end
end
