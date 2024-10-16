Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, singular: :user, controllers: {
        registrations: "api/v1/users/registrations",
        sessions: "api/v1/users/sessions",
      }

      get 'current_user', to: 'auth#verify'
      get '/locations/:id/photos', to: 'locations#photos'
      get 'location_details/:id', to: 'location_details#show'
      get '/reviews/fetch', to: 'reviews#fetch_reviews'
      post '/reviews', to: 'reviews#create'
    
      resources :vouchers
      resources :search_histories, only: [:create, :index]
      resources :bookings, only: [:create, :destroy]
      resources :guestinfos, only: [:create , :destroy]
      resources :payments, only: [:create] do
        collection do
          post 'payment_intents', to: 'payments#create_payment_intent'
        end
      end

    end
  end
end