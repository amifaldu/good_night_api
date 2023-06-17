class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follower_user_relationships, foreign_key: :following_user_id, class_name: 'UserFollowing'
  has_many :following_users, through: :follower_user_relationships, source: :follower_user
end