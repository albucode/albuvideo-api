# frozen_string_literal: true

class WebhookSubscriptionsController < ApplicationController
  before_action :find_webhook_subscription, except: %i[index create]
  before_action :authenticate_user!

  def create
    webhook_subscription = WebhookSubscription.new webhook_subscription_params
    webhook_subscription.user_id = current_user.id
    if webhook_subscription.save
      render json: webhook_subscription, status: :created
    else
      render(
        json: { errors: webhook_subscription.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def index
    webhook_subscriptions = WebhookSubscription.where(user_id: current_user.id).order(created_at: :desc)
    render json: webhook_subscriptions
  end

  def show
    render json: @webhook_subscription
  end

  def update
    if @webhook_subscription.update webhook_subscription_params
      render json: @webhook_subscription
    else
      render(
        json: { errors: @webhook_subscription.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    if @webhook_subscription.destroy
      render json: {}
    else
      render(
        json: { errors: @webhook_subscription.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  private

  def find_webhook_subscription
    @webhook_subscription = WebhookSubscription.find_by!(public_id: params[:id], user: current_user)
  end

  def webhook_subscription_params
    params.require(:webhook_subscription).permit(:topic, :url)
  end
end
