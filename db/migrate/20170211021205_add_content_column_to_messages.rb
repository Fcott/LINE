class AddContentColumnToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :content, :text, null: false, default: ""
  end
end
