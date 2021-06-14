# frozen_string_literal: true

class SignatureKeysController < ApplicationController
  before_action :find_signature_key, except: %i[index create]
  before_action :authenticate_user!

  def create
    signature_key = SignatureKey.new signature_key_params
    signature_key.user_id = current_user.id
    if signature_key.save
      render json: signature_key, status: :created
    else
      render(
        json: { errors: signature_key.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def index
    signature_keys = SignatureKey.where(user_id: current_user.id)
    render json: signature_keys
  end

  def show
    render json: @signature_key
  end

  def destroy
    if @signature_key.destroy
      render json: {}
    else
      render(
        json: { errors: @signature_key.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def update
    if @signature_key.update signature_key_params
      render json: @signature_key, status: :ok
    else
      render(
        json: { errors: @signature_key.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  private

  def find_signature_key
    @signature_key = SignatureKey.find_by!(public_id: params[:id], user: current_user)
  end

  def signature_key_params
    params.require(:signature_key).permit(:name)
  end
end
