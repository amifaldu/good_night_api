class Api::V1::UsersController < ApplicationController
  # User creation
  def create
    if params.present?
      @user = Users.create(name: params[:name])
      if @user.persisted?
        success(I18n.t('api.users.create.success'))
      else
        error(@user.errors.full_messages, :unprocessable_entity)
      end
    else
      error([I18n.t('api.users.create.data_missing')], :unprocessable_entity)
    end
  end

  # Follow users
  def follow_users
    if current_user.present?
      following_user = Users.find_by(id: params[:following_user_id])
      if following_user.present?
        service = FollowUserService.new(current_user, following_user).call
        if service[:success]
          success(service[:message], service[:data])
        else
          error(service[:errors], :unprocessable_entity)
        end
      else
        error([I18n.t('api.users.follow_users.user_not_found')], :unprocessable_entity)
      end
    else
      error([I18n.t('api.users.follow_users.user_not_found')], :unprocessable_entity)
    end
  end

  # Unfollow users
  def unfollow_user
    if current_user.present?
      following_user = Users.find_by(id: params[:unfollow_user_id])
      if following_user.present?
        service = FollowUserService.new(current_user, following_user).unfollow
        if service[:success]
          success(service[:message], service[:data])
        else
          error(service[:errors], :unprocessable_entity)
        end
      else
        error([I18n.t('api.users.unfollow_user.user_not_found')], :unprocessable_entity)
      end
    else
      error([I18n.t('api.users.unfollow_user.user_not_found')], :unprocessable_entity)
    end
  end
end