# # http://localhost:3000/maps/map_id/pins.json へのアクセスをお願いします
# json.array! @pins, :id, :author_id, :title, :description, :created_at, :updated_at, :map_id, :image #:image をつけるとstack too deepエラーが発生する

json.array! @pins, partial: 'pin', as: :pin