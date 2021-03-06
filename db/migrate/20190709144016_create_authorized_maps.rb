# frozen_string_literal: true

class CreateAuthorizedMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :authorized_maps do |t|
      t.references :user, foreign_key: true
      t.references :map, foreign_key: true

      t.timestamps
    end
    add_index :authorized_maps, %i[map_id user_id], unique: true
  end
end
