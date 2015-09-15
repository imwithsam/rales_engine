Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find", to: "merchants#find"
      resources :merchants, only: [:show]
    end
  end
end
