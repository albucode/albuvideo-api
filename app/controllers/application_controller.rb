# frozen_string_literal: true

class ApplicationController < ActionController::Base
  ActiveModelSerializers.config.adapter = :json
  skip_before_action :verify_authenticity_token

  respond_to :json
end
