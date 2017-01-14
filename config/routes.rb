require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # Coming soon
    end
  end
end
