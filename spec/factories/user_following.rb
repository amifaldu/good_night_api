FactoryBot.define do
  factory :user_following do
    association :follower_user, factory: :user
    association :following_user, factory: :user
  end
end