Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  root "home#index"


  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  resources :categories, only: [ :index ]


  resource :cart, only: [ :show ] do
    delete :clear
  end

  resources :products do
    resources :reviews, only: [ :create, :destroy ]
    member do
      post :analyze_with_ai
    end
  end

  resources :cart_items, only: [ :create, :update, :destroy ]

  resources :feedbacks, only: [ :new, :create ]

  resources :orders, only: [ :new, :create, :show, :index ]

  resources :payments, only: [ :new ]
  post "payments/callback", to: "payments#callback", as: :payments_callback

  resources :users, only: [ :index ]
  resources :chat, only: [ :index, :create ]

  get "admin/dashboard", to: "admin#dashboard"
  get "admin/orders", to: "admin_orders#index", as: :admin_orders
  get "admin/reviews", to: "admin_reviews#index", as: :admin_reviews
end
