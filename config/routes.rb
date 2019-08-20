require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # List resources below
      resources :users, :only => [:index, :show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :comparisons, :only => [:show, :index, :create, :update, :destroy] do
        resources :participants, :only => [:index, :show, :create, :update, :destroy]
        resources :decisions, :only => [:index, :show, :create, :update, :destroy]
      end
      resources :test, :only => [:index]
    end
  end

  # apipie generally would be off in production but having it is preferred for this tech demo
  apipie
end
