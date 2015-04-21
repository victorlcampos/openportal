class Users::UnlocksController < Devise::UnlocksController
  skip_before_action :find_all_resources, only: [:index]
  skip_before_action :find_resource     , only: [:show, :edit, :update, :destroy]
  skip_before_action :build_resource    , only: [:new]
  skip_before_action :build_resource_from_params, only: [:create]

  # GET /resource/unlock/new
  # def new
  #   super
  # end

  # POST /resource/unlock
  # def create
  #   super
  # end

  # GET /resource/unlock?unlock_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after sending unlock password instructions
  # def after_sending_unlock_instructions_path_for(resource)
  #   super(resource)
  # end

  # The path used after unlocking the resource
  # def after_unlock_path_for(resource)
  #   super(resource)
  # end
end
