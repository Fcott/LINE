class AddReadAtToUserRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :user_rooms, :last_read_at, :datetime
  end
end
