class AdminController < OpenPortalController
  before_action -> { verify_permission('admin') }
  skip_before_action :find_all_resources
end
