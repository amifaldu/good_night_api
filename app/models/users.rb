class User < ApplicationRecord
  # Associations
  has_many :sleep_records, dependent: :destroy
  has_many :follower_users, foreign_key: :follower_user_id, class_name: :Following
  has_many :following_users, through: :follower_users
   # Validations
  validates :name, presence: true, length: { maximum: 255 }
end

 