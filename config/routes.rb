Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end

  resources :posts, only: [:new, :create]

  # API routes
  post 'api/v1/auth/login', to: 'authentication#login'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
