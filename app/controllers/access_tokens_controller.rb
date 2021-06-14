# frozen_string_literal: true

class AccessTokensController < ApplicationController
  before_action :find_access_token, except: %i[index create]
  before_action :authenticate_user!

  def create
    access_token = AccessToken.new access_token_params
    access_token.user_id = current_user.id
    if access_token.save
      render json: access_token, status: :created
    else
      render(
        json: { errors: access_token.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def index
    access_tokens = AccessToken.where(user_id: current_user.id)
    render json: access_tokens
  end

  def show
    render json: @access_token
  end

  def destroy
    if @access_token.destroy
      render json: {}
    else
      render(
        json: { errors: @access_token.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def update
    if @access_token.update access_token_params
      render json: @access_token, status: :ok
    else
      render(
        json: { errors: @access_token.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  private

  def find_access_token
    @access_token = AccessToken.find_by!(public_id: params[:id], user: current_user)
  end

  def access_token_params
    params.require(:access_token).permit(:name)
  end
end
