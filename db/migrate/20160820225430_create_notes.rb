class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :note1
      t.string :note2
      t.string :note3
      t.integer :id_user

      t.timestamps null: false
    end
  end
end
