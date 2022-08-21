Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: %i[ index show ]
      resources :notifications, except: %i[ index show ]
      resources :user_devices, except: %i[ index show ]
      post '/auth/login', to: 'authentication#login'
    end
  end
end
