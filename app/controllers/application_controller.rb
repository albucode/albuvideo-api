# frozen_string_literal: true

class ApplicationController < ActionController::Base
  ActiveModelSerializers.config.adapter = :json
  skip_before_action :verify_authenticity_token
  rescue_from NotAdminError, with: :deny_access
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  respond_to :json

  private

  def deny_access
    render(
      json: { error: 'Only an admin has access to this record' }
    )
  end

  def record_not_found
    render(
      json: { error: 'This record does not exist' }
    )
  end
end
