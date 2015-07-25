class SettingsController < OpenPortalController

  skip_before_action :find_resource, only: [:edit, :update]

  before_action -> { verify_permission('admin') }
  before_action :get_key
  before_action -> { verify_permission(OPEN_PORTAL_CONFIGS[@key][:permission]) if OPEN_PORTAL_CONFIGS[@key][:permission] }
  before_action :first_or_initialize_setting, only: [:edit, :update]

  def update
    if @resource.update_attributes(safe_params)
      redirect_to action: :edit, id: @key
    else
      render :edit
    end
  end

  protected

  def first_or_initialize_setting
    @resource = Setting.where(key: @key).first_or_initialize
  end

  def get_key
    @key = params[:id]
  end
end
