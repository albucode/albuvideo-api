# frozen_string_literal: true

class CountriesController < ApplicationController
  def index
    countries = Country.all
    render json: countries
  end
end
