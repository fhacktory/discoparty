Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :search, only: :show
      resources :playlists, only: :show do
        resources :tracks, only: :create do
          resources :loves, only: [:create, :destroy]
          resources :hates, only: [:create, :destroy]
        end
      end
    end
  end

  resources :playlists, only: [:create, :show]

  get '/styleguide', to: 'home#styleguide'

  root to: 'home#index'
end
