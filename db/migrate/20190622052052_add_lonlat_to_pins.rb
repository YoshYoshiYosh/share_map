class AddLonlatToPins < ActiveRecord::Migration[5.2]
  def change
    add_column :pins, :lonlat, :st_point, geographic: true
  end
end
