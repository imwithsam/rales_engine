Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "customers/find", to: "customers#find"
      get "customers/find_all", to: "customers#find_all"
      get "customers/random", to: "customers#random"
      resources :customers, only: [:index, :show]
      get "customers/invoices", to: "customers#invoices"
      get "customers/transactions", to: "customers#transactions"

      get "invoice_items/find", to: "invoice_items#find"
      get "invoice_items/find_all", to: "invoice_items#find_all"
      get "invoice_items/random", to: "invoice_items#random"
      resources :invoice_items, only: [:index, :show]
      get "invoice_items/:id/invoice", to: "invoice_items#invoice"
      get "invoice_items/:id/item", to: "invoice_items#item"

      get "invoices/find", to: "invoices#find"
      get "invoices/find_all", to: "invoices#find_all"
      get "invoices/random", to: "invoices#random"
      resources :invoices, only: [:index, :show]
      get "invoices/:id/transactions", to: "invoices#transactions"
      get "invoices/:id/invoice_items", to: "invoices#invoice_items"
      get "invoices/:id/items", to: "invoices#items"
      get "invoices/:id/customer", to: "invoices#customer"
      get "invoices/:id/merchant", to: "invoices#merchant"

      get "items/find", to: "items#find"
      get "items/find_all", to: "items#find_all"
      get "items/random", to: "items#random"
      resources :items, only: [:index, :show]
      get "items/:id/invoice_items", to: "items#invoice_items"
      get "items/:id/merchant", to: "items#merchant"

      get "transactions/find", to: "transactions#find"
      get "transactions/find_all", to: "transactions#find_all"
      get "transactions/random", to: "transactions#random"
      resources :transactions, only: [:index, :show]
      get "transactions/:id/invoice", to: "transactions#invoice"

      get "merchants/find", to: "merchants#find"
      get "merchants/find_all", to: "merchants#find_all"
      get "merchants/random", to: "merchants#random"
      get "merchants/most_revenue", to: "merchants#most_revenue"
      get "merchants/most_items", to: "merchants#most_items"
      get "merchants/revenue", to: "merchants#total_revenue"
      resources :merchants, only: [:index, :show]
      get "merchants/:id/items", to: "merchants#items"
      get "merchants/:id/invoices", to: "merchants#invoices"
      get "merchants/:id/revenue", to: "merchants#revenue"
    end
  end
end
