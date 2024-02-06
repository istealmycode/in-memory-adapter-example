# frozen_string_literal: true

Rails.application.routes.draw do
  root 'weather#index'
  get '/weather', to: 'weather#index'
  get '/weather/search', to: 'weather#search'
end
