require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # List resources below
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :comparisons, :only => [:show, :index, :create, :update, :destroy] do
        resources :participants, :only => [:index]
      end
    end
  end
end
