class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :license_plate, presence: true, uniqueness: {
    scope: :state
  }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token

  def remember_me
    true
  end

  private

  def generate_authentication_token
    _, token = Devise.token_generator.generate(User, :authentication_token)
    self.authentication_token = token
  end
end

