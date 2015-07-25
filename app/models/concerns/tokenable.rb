module Tokenable
  extend ActiveSupport::Concern

  included do
    before_save :ensure_authentication_token
  end

  class_methods do
  end

  private

  def ensure_authentication_token
    return unless authentication_token.blank? || try(:encrypted_password_changed?)
    self.authentication_token = generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.where(authentication_token: token).first
    end
  end
end
