# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :videos, only: %i[index show destroy create]
  end
end
