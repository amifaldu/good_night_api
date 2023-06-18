class UserFollowing < ApplicationRecord
  # Associations
  belongs_to :follower_user, class_name: 'Users'
  belongs_to :following_user, class_name: 'Users'
end