class ViewObject < ActionView::Base
  include Rails.application.helpers
  include Rails.application.routes.url_helpers
end
