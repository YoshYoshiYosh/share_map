class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :title
      t.text :description
      # t.integer :author, index: true
      t.references :author, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end