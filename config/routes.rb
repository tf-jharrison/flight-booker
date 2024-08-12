Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :bookings do 
    put :soft_delete, on: :member
  end
  resources :flights, only: [:index]
  post '/webhook', to: 'stripe#webhook'
  root "flights#index"
  get "purchase_success", to: 'stripe#purchase_success'
  get "cancel_purchase", to: 'stripe#cancel_purchase'
  post "create-checkout-session", to: "stripe#create_checkout_session"
  get "payment_confirmed", to: "bookings#payment_confirmed"
  # these were here as default
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
