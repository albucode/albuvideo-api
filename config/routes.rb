# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resource :current_user, only: :show, controller: :current_user
  resources :videos, only: %i[index show destroy create] do
    resource :stats, only: :show, controller: :video_stats
  end
  resources :access_tokens
  resources :signature_keys
  resources :webhook_subscriptions
  resource  :stats, only: :show
  resources :countries, only: :index

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
