# frozen_string_literal: true

json.array! @authorized_users, :id, :email, :created_at, :updated_at
