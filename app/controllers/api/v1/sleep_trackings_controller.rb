  class Api::V1::SleepTrackingsController < ApplicationController
    def index
      user = Users.find_by(id: params[:user_id])
      sleep_trackings = user.following_users.last_week_sleep_trackings.as_json
      render json: sleep_trackings
    end

    ##
    # > Clock in the current user for sleep tracking.
    def clock_in
      service = SleepTrackingService.new(current_user).clock_in
      if service[:success]
        success(service[:message],service[:data] )
      else
        error(service[:errors],:unprocessable_entity)
      end
    end

    ##
    # > Clock out the current user for sleep tracking.
    def clock_out
      service = SleepTrackingService.new(current_user).clock_out
      if service[:success]
        success(service[:message],service[:data] )
      else
        error(service[:errors],:unprocessable_entity)
      end
    end
  end