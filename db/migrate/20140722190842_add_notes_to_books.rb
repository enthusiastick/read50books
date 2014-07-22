class AddNotesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :brief, :string
    add_column :books, :note, :text
  end
end
