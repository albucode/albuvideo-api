# frozen_string_literal: true

class ApplicationController < ActionController::Base
  ActiveModelSerializers.config.adapter = :json
end
