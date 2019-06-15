class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :title
      t.text :description
      t.integer :author, index: true

      t.timestamps
    end
    add_foreign_key :maps, :users, column: :author
  end
end
