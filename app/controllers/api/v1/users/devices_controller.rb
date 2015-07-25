class Api::V1::Users::DevicesController < OpenPortalApiController
  skip_before_action :build_resource_from_params, only: [:create]
  before_filter :authenticate_user_from_token!

  def create
    device = Device.find_or_initialize_by(params.require(:device).permit(:push_id))

    device.user = current_user
    device.save!
    render json: { push_id: device.push_id }.to_json
  end
end
