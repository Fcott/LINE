class AddLastMessageColumnToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :last_message, :datetime
  end
end
