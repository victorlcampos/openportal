class OpenPortalApiController < OpenPortalController
  skip_before_action :verify_permission

  skip_before_action -> { can_view? }, only: [:index, :show]
  skip_before_action -> { can_create? }, only: [:new,   :create]
  skip_before_action -> { can_edit? }, only: [:edit,  :update]
  skip_before_action -> { can_delete? }, only: [:destry]

  def create
    if @resource.save
      render status: 201, json: @resourse.to_json
    else
      render status: 400, json: @resource.errors.to_json
    end
  end

  protected

  def id_param
    :user_id
  end

  def authenticate_user_from_token!
    authenticate_or_request_with_http_token do |token, _option|
      user_id = params[id_param].presence
      user       = user_id && User.find_by_id(user_id)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end
end
