class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  before_action :set_user, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[ index show update destroy me ]

  def index
    if @current_user.admin?
      @users = User.all
      render json: @users
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  def show
    if admin_or_current_user?
      render json: @user
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  def update
    if admin_or_current_user?
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  def destroy
    if admin_or_current_user?
      @user.destroy
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  def me
    user = User.find(@current_user.id)
    render json: user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if @current_user.admin?
        params.require(:user).permit(:first_name, :last_name, :role)
      else
        params.require(:user).permit(:first_name, :last_name)
      end
    end

    def set_current_user
      @current_user = current_devise_api_token.resource_owner
    end

    def admin_or_current_user?
      return @current_user.admin? || @current_user == @user
    end
end
