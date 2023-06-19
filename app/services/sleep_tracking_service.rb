class SleepTrackingService
  attr_reader :response

  def initialize(user)
    @current_user = user
    @response = {
      success: false,
      errors: [],
      message: '',
      data: nil
    }
  end

  def clock_in
    # Check if there is a pending sleep record without a sleep end time
    last_sleep_record = @current_user.sleep_records.find_by(sleep_end: nil)
    if last_sleep_record.present?
      add_error(I18n.t('api.users.clock_in.clock_out_remaining'))
      return @response
    end
    # Create a new sleep record with the current time as the sleep start time
    sleep_record = @current_user.sleep_records.create(sleep_start: Time.zone.now)
    if sleep_record.persisted?
      saved_records = @current_user.sleep_records.order(created_at: :asc)
      set_success(I18n.t('api.users.clock_in.success'), saved_records)
    else
      add_error(I18n.t('api.users.clock_in.error'))
    end
    return @response
  end

  def clock_out
    # Find the last sleep record without a sleep end time
    last_sleep_record = @current_user.sleep_records.find_by(sleep_end: nil)
    if last_sleep_record.present? && last_sleep_record.sleep_end.nil?
      current_time = Time.zone.now
      update_record = last_sleep_record.update!(sleep_end: current_time, sleep_duration: (current_time - last_sleep_record.sleep_start))
      set_success(I18n.t('api.users.clock_out.success'), update_record)
    else
      add_error(I18n.t('api.users.clock_out.error'))
    end
    return @response
  end

  private

  def add_error(message)
    @response[:errors] << message
  end

  def set_success(message, data)
    @response[:success] = true
    @response[:message] = message
    @response[:data] = data
  end
end
