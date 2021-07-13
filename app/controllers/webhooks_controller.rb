# frozen_string_literal: true

class WebhooksController < ApplicationController
  before_action :find_webhook, except: %i[index create]
  before_action :authenticate_user!

  def create
    webhook = Webhook.new webhook_params
    webhook.user_id = current_user.id
    if webhook.save
      render json: webhook, status: :created
    else
      render(
        json: { errors: webhook.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def index
    webhooks = Webhook.where(user_id: current_user.id).order(created_at: :desc)
    render json: webhooks
  end

  def show
    render json: @webhook
  end

  def update
    if @webhook.update webhook_params
      render json: @webhook, status: :ok
    else
      render(
        json: { errors: @webhook.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    if @webhook.destroy
      render json: {}
    else
      render(
        json: { errors: @webhook.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  private

  def find_webhook
    @webhook = Webhook.find_by!(public_id: params[:id], user: current_user)
  end

  def webhook_params
    params.require(:webhook).permit(:topic, :url)
  end
end
