class User < ApplicationRecord
  # Authentication token for user must be unique
  validates :auth_token, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Create unique authentication token before created
  before_validation :generate_authentication_token!

  # A user can own comparisons
  has_many :comparisons, foreign_key: 'owner_id', dependent: :destroy

  def generate_authentication_token!
   begin
     self.auth_token = Devise.friendly_token
   end while self.class.exists?(auth_token: auth_token)
  end
end
