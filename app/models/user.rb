class User < ActiveRecord::Base
  mount_uploader :profile_photo, AvatarUploader

  has_many :purchases
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }
end
