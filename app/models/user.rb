# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :videos, dependent: :destroy
  has_many :video_watch_events, dependent: :destroy
  has_many :access_tokens, dependent: :destroy
  has_many :signature_keys, dependent: :destroy
  has_many :webhooks, dependent: :destroy
end
