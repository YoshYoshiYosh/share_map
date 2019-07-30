#scaffoldのコード json.array! @pins, partial: "pins/pin", as: :pin

# @pins.each do |pin|
#   pin.lonlat = 
# end

json.array! @pins, :id, :author_id, :title, :description, :created_at, :updated_at, :map_id # :lonlat をつけるとstack too deepエラーが発生する