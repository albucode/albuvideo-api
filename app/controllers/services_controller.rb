# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :find_service, except: %i[index create]
  before_action :admin?
  before_action :authenticate_user!
  rescue_from StandardError, with: :deny_access

  def create
    service = Service.new service_params
    if service.save
      render json: service, status: :created
    else
      render(
        json: { errors: service.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def index
    services = Service.all
    render json: services
  end

  def show
    render json: @service
  end

  def destroy
    if @service.destroy
      render json: {}
    else
      render(
        json: { errors: @service.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def update
    if @service.update service_params
      render json: @service
    else
      render(
        json: { errors: @service.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  private

  def find_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :category, :description, :price)
  end

  def admin?
    raise StandardError unless current_user.is_admin
  end

  def deny_access
    render(
      json: { error: 'Only an admin has access to services' }
    )
  end
end
