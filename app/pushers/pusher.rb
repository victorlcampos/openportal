class Pusher

  def initialize
    @app = Rpush::Gcm::App.find_by_name(Rails.application.secrets.gcm['name'])
  end

  def self.create_or_update_app
    gcm = Rails.application.secrets.gcm
    app_name = gcm['name']

    app = Rpush::Gcm::App.find_by_name(app_name) || Rpush::Gcm::App.new
    app.name = app_name
    app.auth_key = gcm['auth_key']
    app.connections = gcm['connections']
    app.save!
  end

  def push(registration_ids, message)
    return if registration_ids.empty?

    n = Rpush::Gcm::Notification.new
    n.app = @app
    n.registration_ids = registration_ids
    n.data = { message: message }
    n.save!
  end
end
