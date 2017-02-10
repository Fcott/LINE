class AddDirectsToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :direct, :boolean, default: false
  end
end
