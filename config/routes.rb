Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find", to: "merchants#find"
      get "merchants/find_all", to: "merchants#find_all"
      get "merchants/random", to: "merchants#random"
      resources :merchants, only: [:show]
    end
  end
end
