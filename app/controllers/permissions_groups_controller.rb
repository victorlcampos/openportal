class PermissionsGroupsController < ApplicationController
  before_action -> { verify_permission('admin') }

  def show
    redirect_to action: :index
  end
end
