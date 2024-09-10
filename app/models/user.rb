class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include ::Ransackable
  has_many :search_histories, dependent: :destroy
  has_many :reviews

  # Include Devise modules
  devise :database_authenticatable, :registerable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  # Ensure that the user has a `jti` value (JWT ID) when created or updated
  before_create :generate_jti

  # Method to generate a new `jti` value (called on user creation)
  def generate_jti
    self.jti = SecureRandom.uuid
  end

  # Method to revoke the current JWT by updating the `jti`
  def self.revoke_jwt(_payload, user)
    user.update!(jti: SecureRandom.uuid)
  end

  # Method to check if the token's `jti` matches the user's current `jti`
  def self.jwt_revoked?(payload, user)
    payload['jti'] != user.jti
  end
end  