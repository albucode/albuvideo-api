# frozen_string_literal: true

class StatsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: ReturnVideoStats.perform(current_user)
  end
end
