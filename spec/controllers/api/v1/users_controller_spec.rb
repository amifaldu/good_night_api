require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'John Doe' } }
      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end
      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to be_successful
      end
    end
    context 'with missing parameters' do
      it 'returns an error response' do
        post :create, params: {}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #follow_users' do
    let(:current_user) { create(:user) }
    let(:following_user) { create(:user) }
    let(:valid_params) { { following_user_id: following_user.id } }
    context 'with valid parameters' do
      it "follows the specified user" do
        user = create(:user) 
        following_user = create(:user)
        post :follow_users, params: { id: user.id, following_user_id: following_user.id }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'DELETE #unfollow_user' do
    let(:current_user) { create(:user) }
    let(:following_user) { create(:user) }
    let!(:user_following) { create(:user_following, follower_user: current_user, following_user: following_user) }
    context 'with valid parameters' do
      it 'destroys the user' do
        user = create(:user) 
        following_user = create(:user)
        service_instance = instance_double(FollowUserService)
        allow(FollowUserService).to receive(:new).and_return(service_instance)
        expect(service_instance).to receive(:unfollow).and_return(success: true, message: 'User unfollowed successfully', data: nil)
        delete :unfollow_user, params: { id: user.id, unfollow_user_id: following_user.id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
