Rails.application.routes.draw do
  devise_for :users

  root to: "events#index"

  resources :events, only: %i[show new create] do
    resources :participations, only: [:create]
  end

  resources :publications, only: %i[index create] do
    resources :comments, only: %i[index create]
  end

  get "search", to: "events#search", as: :search
  get "my_events", to: "events#my_events", as: :my_events

  get "up" => "rails/health#show", as: :rails_health_check

end
