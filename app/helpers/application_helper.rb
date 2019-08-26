module ApplicationHelper
  def require_flash?
    request.url !~ %r{http://localhost:3000/maps/\d/authorizing/new} ? true : false
  end
end
