RSpec.describe FollowUserService do
  describe '#call' do
    let(:user) { create(:user) }
    let(:following_user) { create(:user) }
    let(:service) { described_class.new(user, following_user) }

    context 'when both user and following_user are present' do
      it 'creates a follower_user association' do
        expect { service.call }.to change { user.following_users.count }.by(1)
      end

      it 'returns true' do
        expect(service.call).to be true
      end
    end

    context 'when user or following_user is not present' do
      let(:user) { nil }

      it 'does not create a follower_user association' do
        expect { service.call }.not_to change { user.following_users.count }
      end

      it 'returns false' do
        expect(service.call).to be false
      end
    end
  end
end