Rails.application.routes.draw do
  get 'locations/photos'
  get 'location_details/show'
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, singular: :user, controllers: {
        registrations: "api/v1/users/registrations",
        sessions: "api/v1/users/sessions",
      }
    end
  end

  # Add routes for SearchHistoriesController
   resources :search_histories, only: [:create, :index]
  # resources :reviews, only: [:create]
   get 'current_user' , to: 'auth#verify'
   get '/locations/:id/photos', to: 'locations#photos'
   get 'location_details/:id', to: 'location_details#show'
end
