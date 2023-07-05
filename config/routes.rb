Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  devise_scope :user do
    get 'login', to 'devise/sessions#new'
    get 'sign_up', to 'devise/registrations#new'
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
