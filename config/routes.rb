require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # List resources below
      resources :users, :only => [:show]
    end
  end
end
