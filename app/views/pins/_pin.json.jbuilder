# json.extract! pin, :id, :author_id, :title, :description, :lonlat, :created_at, :updated_at, :map_id
# json.url map_pins_url(format: :json)

json.id           pin.id
json.author_id    pin.author_id
json.lonlat       [pin.lonlat.x, pin.lonlat.y]
json.title        pin.title
json.description  pin.description
json.created_at   pin.created_at
json.updated_at   pin.updated_at
json.map_id       pin.map_id
json.image        url_for(pin.image)