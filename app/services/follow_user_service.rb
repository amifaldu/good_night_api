class FollowUserService
  attr_reader :response
  def initialize(user, following_user)
    @user = user
    @following_user = following_user
    @response = {
      success: false,
      errors: [],
      message: '',
      data: nil
    }
  end

  def call
    validate_users && create_follower_user
  end

  def unfollow
    validate_users && destroy_follower_user
  end

  private
  # Validates that both user and following_user are present
  def validate_users
    return true if @user.present? && @following_user.present?
    add_error(I18n.t('api.users.follow_users.required_user'))
    return response
  end

  # Creates a follower_user association between the user and following_user
  def create_follower_user
    if already_following?
      add_error(I18n.t('api.users.follow_users.already_register'))
      return response
    else
      following_user = @user.following_users << @following_user
      set_success(I18n.t('api.users.follow_users.success'), following_user)
      return response
    end
  end
  #unfollow the user
  def destroy_follower_user
    following_user = UserFollowing.find_by(follower_user_id: @user.id, following_user_id: @following_user.id)
    if following_user.present?
      delete_user = following_user.destroy
      set_success(I18n.t('api.users.unfollow_user.success'), delete_user)
      return response
    else
      add_error([I18n.t('api.users.unfollow_user.not_following')])
      return response
    end
  end
  # Checks if the user is already following the specified following_user
  def already_following?
    @user.following_users.exists?(@following_user.id)
  end

  # Returns an array of errors
  def add_error(message)
    @response[:errors] << message
  end

  def set_success(message, data)
    @response[:success] = true
    @response[:message] = message
    @response[:data] = data
  end
end