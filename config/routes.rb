Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :pages, only: [:update]
  end

  resources :sessions, only: [:create]
  resource :session, only: [:destroy]

  resources :pages, only: [:show]

  root to: "pages#index"
end
