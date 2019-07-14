class CreatePins < ActiveRecord::Migration[5.2]
  def change
    create_table :pins do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.string :title
      t.text :description
      t.st_point :lonlat

      t.timestamps
    end
  end
end
