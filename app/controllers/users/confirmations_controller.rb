class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :find_all_resources, only: [:index]
  skip_before_action :find_resource     , only: [:show, :edit, :update, :destroy]
  skip_before_action :build_resource    , only: [:new]
  skip_before_action :build_resource_from_params, only: [:create]

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
