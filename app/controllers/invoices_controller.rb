# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    invoices = Invoice.where(user_id: current_user.id).order(created_at: :desc)
    render json: invoices
  end
end
