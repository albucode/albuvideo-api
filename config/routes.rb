# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :videos, only: %i[index show destroy create]
end
