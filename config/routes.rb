Rails.application.routes.draw do
  devise_for :users
  
  authenticated :user do
    mount ActionCable.server => '/cable'
    root 'dashboard#index', as: :authenticated_root
  end
  
  resources :expenses
  resources :categories
  resources :conversations, only: [:index, :show, :create] do
    collection do
      get :search
    end
    resources :messages, only: [:create]
  end
  resources :ai_chats, only: [:create]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  root to: redirect('/users/sign_up')
end
