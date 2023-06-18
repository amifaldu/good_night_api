require 'rails_helper'
RSpec.describe FollowUserService do
  let(:user) { create(:user) }
  let(:following_user) { create(:user) }
  let(:service) { FollowUserService.new(user, following_user) }

  describe '#call' do
    context 'with valid parameters' do
      it 'returns a success response' do
        expect(service.call[:success]).to be true
        expect(service.call[:message]).to eq('User followed successfully')
        expect(service.call[:data]).to include(following_user)
      end

      it 'creates a follower_user association' do
        expect {
          service.call
        }.to change { user.following_users.count }.by(1)
      end

      it 'does not create duplicate associations' do
        service.call
        expect {
          service.call
        }.not_to change { user.following_users.count }
      end
    end
  end

   describe '#unfollow' do
    let(:user) { create(:user) }
    let(:following_user) { create(:user) }
    let(:service) { FollowUserService.new(user, following_user) }

    context 'when both user and following_user are present' do
      before do
        user.following_users << following_user
      end
      it 'destroys the follower_user association and returns a success response' do
        expect(service.unfollow[:success]).to be true
        expect(service.unfollow[:message]).to eq('User unfollowed successfully')
      end
    end

    context 'when either user or following_user is missing' do
      it 'returns an error response' do
        expect(service.unfollow).to eq({
          success: false,
          errors: ["User is not following the specified user"],
          message: '',
          data: nil
        })
      end
    end

    context 'when the user is not following the specified following_user' do
      it 'returns an error response' do
        expect(service.unfollow).to eq({
          success: false,
          errors: ["User is not following the specified user"],
          message: '',
          data: nil
        })
      end
    end
  end
end