# frozen_string_literal: true

json.extract! map, :id, :title, :description, :author_id, :created_at, :updated_at
json.url map_url(map, format: :json)
