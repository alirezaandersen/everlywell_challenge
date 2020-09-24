class UsersController < ApplicationController
  def index
    @user = User.all
    render json: @user, each_serializer: Users::IndexSerializer, status: :ok
  end

  def show
    @user = User.includes(:website).find(params[:id])
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    @user.website.get_additional_info
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def search_for_expert
    @experts = ExpertFinder.new(search_params).find_experts_user
    if @experts.present?
      render :json, @experts.to_json, status: :ok
    else
      render json: @experts.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, website_attributes: [:original_url])
  end

  def search_params
    params.require(:user).permit(:user_id, :search_string)
  end
end
