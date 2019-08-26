# json.partial! "pins/pin", pin: @pin
json.array! @pins, :id, :author_id, :title, :description, :created_at, :updated_at, :map_id
