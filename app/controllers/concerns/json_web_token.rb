require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern

  # The secret must be a string.
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def jwt_encode(payload, exp = 3.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new decoded
  end
end