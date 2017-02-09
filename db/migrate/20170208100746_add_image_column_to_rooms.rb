class AddImageColumnToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :image, :string
  end
end
