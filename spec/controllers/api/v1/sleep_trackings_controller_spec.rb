require 'rails_helper'
RSpec.describe Api::V1::SleepTrackingsController, type: :controller do
  let(:user) { create(:user) }
  #list last week sleep trackings for the user
  describe 'GET #index' do
    it 'returns the last week sleep trackings for the user' do
      user = create(:user)
      following_user = create(:user)
      create_list(:sleep_record, 5, user: following_user, created_at: 1.week.ago)
      create_list(:sleep_record, 3, user: following_user, created_at: Time.current)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      sleep_trackings = user.following_users.last_week_sleep_trackings.as_json
      expect(JSON.parse(response.body)).to match_array(sleep_trackings)
    end
  end
  # clock in
  describe 'POST #clock_in' do
    it 'clocks in the current user for sleep tracking' do
      expect {
        post :clock_in, params: { user_id: user.id }
      }.to change { user.sleep_records.count }.by(1)
      expect(response).to have_http_status(:success)
    end
  end
  # clock out
  describe 'POST #clock_out' do
    it 'clocks out the current user for sleep tracking' do
      sleep_tracking = create(:sleep_record, user: user, sleep_end: nil)
      expect {
        post :clock_out, params: { user_id: user.id }
      }.to change { sleep_tracking.reload.sleep_end }.from(nil)
      expect(response).to have_http_status(:success)
    end
  end
end