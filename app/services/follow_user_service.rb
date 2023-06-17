class FollowUserService
  def initialize(user, following_user)
    @user = user
    @following_user = following_user
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
    errors << I18n.t('api.users.follow_users.required_user')
    false
  end

  # Creates a follower_user association between the user and following_user
  def create_follower_user
    if already_following?
      errors << I18n.t('api.users.follow_users.already_register')
      false
    else
      @user.following_users << @following_user
      true
    end
  end
  #unfollow the user
  def destroy_follower_user
    following_user = UserFollowing.find_by(follower_user_id: @user.id, following_user_id: @following_user.id)
    if following_user.present?
      following_user.destroy
      return true
    else
      return false
    end
  end

  # Checks if the user is already following the specified following_user
  def already_following?
    @user.following_users.exists?(@following_user.id)
  end

  # Returns an array of errors
  def errors
    @errors ||= []
  end
end