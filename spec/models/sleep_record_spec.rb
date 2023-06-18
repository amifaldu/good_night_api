require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  # Test the associations of the User model
  describe 'associations' do
    it {should belong_to(:user)}
  end

  # Test the validations of the User model
  describe 'validations' do
    it {should validate_presence_of(:sleep_start)}
  end
end