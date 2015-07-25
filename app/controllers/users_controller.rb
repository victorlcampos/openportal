class UsersController < OpenPortalController
  before_action -> { verify_permission('admin') }

  protected

  def form_attributes
    ['email', 'password', 'password_confirmation']
  end

  def index_attributes
    ['email']
  end
end
