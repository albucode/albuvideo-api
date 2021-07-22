# frozen_string_literal: true

class StatsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: UserStats.perform(current_user)
  end
end
