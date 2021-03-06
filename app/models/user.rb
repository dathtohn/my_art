# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :picture, :description
  has_secure_password
  has_attached_file :picture, styles: { thumb: "500x500#" },
                      storage: :s3,
                      s3_credentials: S3_CREDENTIALS,
                      default_url: "https://s3.amazonaws.com/my-art/images/myart.jpg",
                      path: "/:attachment/:id/:style.:extension"
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :collections, dependent: :destroy

	before_save { email.downcase! }
	before_save :create_remember_token

  validates :name,	presence: :true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :description, length: { maximum: 300 }

  private

	  def create_remember_token
	    self.remember_token = SecureRandom.urlsafe_base64
	  end
end
