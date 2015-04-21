class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :find_all_resources, only: [:index]
  skip_before_action :find_resource     , only: [:show, :edit, :update, :destroy]
  skip_before_action :build_resource    , only: [:new]
  skip_before_action :build_resource_from_params, only: [:create]

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
