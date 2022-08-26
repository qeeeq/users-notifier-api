Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :notifications, except: %i[ index show ]
      resources :user_devices, except: %i[ index show ]
      post '/auth/login', to: 'authentication#login'
    end
  end
end
