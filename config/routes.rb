Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'

  resources :rooms do
    collection do
      get 'home',to:'home'
      get 'search'
      post 'search'
    end
  end

  resources :reservations, only: [:index, :new, :create] do
    collection do
      post :confirm
    end
  end

  devise_for :users
  get "users/show" => "users#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
