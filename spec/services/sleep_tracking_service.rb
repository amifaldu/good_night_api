require 'rails_helper'

RSpec.describe SleepTrackingService do
  let(:user) { create(:user) }
  let(:service) { SleepTrackingService.new(user) }

  describe '#clock_in' do
    context 'when there is no pending sleep record' do
      it 'creates a new sleep record and returns success response' do
        expect {
          service.clock_in
        }.to change { user.sleep_records.count }.by(1)
        expect(service.response[:success]).to eq(true)
        expect(service.response[:errors]).to be_empty
        expect(service.response[:message]).to eq(I18n.t('api.users.clock_in.success'))
        expect(service.response[:data]).to eq(user.sleep_records.order(created_at: :asc))
      end
    end

    context 'when there is a pending sleep record' do
      it 'returns an error response' do
        create(:sleep_record, user: user, sleep_end: nil)

        expect {
          service.clock_in
        }.not_to change { user.sleep_records.count }

        expect(service.response[:success]).to eq(false)
        expect(service.response[:errors]).to include(I18n.t('api.users.clock_in.clock_out_remaining'))
        expect(service.response[:message]).to be_empty
        expect(service.response[:data]).to be_nil
      end
    end
  end

  describe '#clock_out' do
    context 'when there is a pending sleep record' do
      it 'updates the sleep record with sleep end time and returns success response' do
        sleep_record = create(:sleep_record, user: user, sleep_end: nil)
        current_time = Time.zone.now
        expect {
          service.clock_out
        }.to change { sleep_record.reload.sleep_end}.from(nil)
        expect(service.response[:success]).to eq(true)
        expect(service.response[:errors]).to be_empty
        expect(service.response[:message]).to eq(I18n.t('api.users.clock_out.success'))
      end
    end

    context 'when there is no pending sleep record' do
      it 'returns an error response' do
        expect {
          service.clock_out
        }.not_to change { user.sleep_records.count }

        expect(service.response[:success]).to eq(false)
        expect(service.response[:errors]).to include(I18n.t('api.clock_out.error'))
        expect(service.response[:message]).to be_empty
        expect(service.response[:data]).to be_nil
      end
    end
  end
end