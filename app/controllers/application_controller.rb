class ApplicationController < ActionController::API
  include JsonResponseHandler

  # Returns the currently authenticated user
  def current_user
    @current_user ||= Users.find_by(id: (params[:user_id] || params[:id]))
  end
end