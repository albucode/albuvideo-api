# frozen_string_literal: true

class CountriesController < ApplicationController
  before_action :authenticate_user!

  def index
    countries = Country.all
    render json: countries
  end
end
