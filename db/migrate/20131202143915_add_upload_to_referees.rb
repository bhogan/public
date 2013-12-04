class AddUploadToReferees < ActiveRecord::Migration
  def change
    add_column :referees, :upload, :string
  end
end
