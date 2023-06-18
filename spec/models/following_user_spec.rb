RSpec.describe FollowingUser, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      following_user = build(:following_user)
      expect(following_user).to be_valid
    end
  end
end