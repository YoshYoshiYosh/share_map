json.id           pin.id
json.author_id    pin.author_id
json.lonlat       x: pin.lonlat.x, y: pin.lonlat.y
json.title        pin.title
json.description  pin.description
json.created_at   pin.created_at
json.updated_at   pin.updated_at
json.map_id       pin.map_id
json.image        url_for(pin.image) if pin.image.attached?