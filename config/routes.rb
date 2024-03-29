Rails.application.routes.draw do
  devise_for :users
  root to: 'trips#index'

  get '/home', to: 'pages#home', as:'home'
  get '/about', to:'pages#about', as:'about'
  get '/faq', to:'pages#faq', as:'faq'
  get '/contact', to:'pages#contact', as:'contact'

  resources :trips do
    resources :date_ranges, only: :create
    resources :activities, only: :create
  end

  resources :date_ranges, only: [:edit, :update, :destroy]

  resources :activities, only: [:edit, :update, :destroy] do
    resources :breakdowns, only: [:new, :create]
  end

  resources :breakdowns, only: [:edit, :update, :destroy]

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
