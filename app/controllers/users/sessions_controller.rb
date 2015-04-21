class Users::SessionsController < Devise::SessionsController

  skip_before_action :find_all_resources, only: [:index]
  skip_before_action :find_resource     , only: [:show, :edit, :update, :destroy]
  skip_before_action :build_resource    , only: [:new]
  skip_before_action :build_resource_from_params, only: [:create]

# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
