class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author, null: false
      t.string :title, null: false
      t.references :user, null: false
      t.datetime :date_completed, null: false

      t.timestamps
    end
  end
end
