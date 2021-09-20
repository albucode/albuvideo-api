# frozen_string_literal: true

class OptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    options = { topics: WebhookSubscription::TOPICS }
    render json: options
  end
end
