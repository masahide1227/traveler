Rails.application.routes.draw do
  get 'chat_rooms/index'
  get 'chat_rooms/show'
  get 'chat_rooms/create'
  devise_for :users
  resources :users, only:[:index, :show]
  resources :posts do
    resources :comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
    collection do
      get 'confirm'
    end
  end

  resources :chat_rooms, only: [:index, :show, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root :to => 'homes#top'

  resources :users, only:[:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

end
