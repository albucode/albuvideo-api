# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resource :current_user, only: :show, controller: :current_user
  resources :videos, only: %i[index show destroy create]
  resources :access_tokens
  resources :signature_keys
end
