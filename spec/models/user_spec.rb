# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Test the associations of the User model
  describe 'associations' do
    it { should have_many(:sleep_records).dependent(:destroy) }
    it { should have_many(:follower_users).with_foreign_key(:follower_user_id).class_name('UserFollowing') }
    it { should have_many(:following_users).through(:follower_users).source(:following_user) }
  end

  # Test the validations of the User model
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end
end