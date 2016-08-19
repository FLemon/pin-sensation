class User < ApplicationRecord
  devise :database_authenticatable, :timeoutable,
    :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :user_omniauths

  has_many :messages
  has_many :chatroom, through: :messages
  has_many :items
  validates :name, presence: true, uniqueness: true

  def self.from_omniauth!(auth)
    joins(:user_omniauths).where(user_omniauths: { provider: auth.provider, uid: auth.uid }).first_or_create! do |user|
      user.user_omniauths.build(provider: auth.provider, uid: auth.uid)
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
