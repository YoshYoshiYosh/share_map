json.extract! pin, :id, :author_id, :title, :description, :lonlat, :created_at, :updated_at, :map_id
json.url map_pins_url(format: :json)