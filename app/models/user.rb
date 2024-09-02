class User < ApplicationRecord
  include ::Ransackable
  has_many :search_histories, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, :database_authenticatable, jwt_revocation_strategy: self

end
