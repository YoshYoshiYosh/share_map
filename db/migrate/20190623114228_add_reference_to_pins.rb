class AddReferenceToPins < ActiveRecord::Migration[5.2]
  def change
    add_reference :pins, :map, index: true
  end
end
