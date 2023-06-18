require 'rails_helper'
RSpec.describe FollowUserService do
  let(:user) { create(:user) }
  let(:following_user) { create(:user) }
  let(:service) { FollowUserService.new(user, following_user) }

  describe '#call' do
    context 'with valid parameters' do
      it 'returns a success response' do
        expect(service.call[:success]).to be true
        expect(service.call[:message]).to eq(I18n.t('api.users.follow_users.success'))
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
        expect(service.unfollow[:message]).to eq(I18n.t('api.users.unfollow_user.success'))
      end
    end

    context 'when either user or following_user is missing' do
      it 'returns an error response' do
        expect(service.unfollow).to eq({
          success: false,
          errors: [I18n.t('api.users.unfollow_user.user_not_found')],
          message: '',
          data: nil
        })
      end
    end

    context 'when the user is not following the specified following_user' do
      it 'returns an error response' do
        expect(service.unfollow).to eq({
          success: false,
          errors: [I18n.t('api.unfollow_user.not_following')],
          message: '',
          data: nil
        })
      end
    end
  end
end