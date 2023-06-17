class UserFollowings < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :following_user, class_name: 'User'
end