Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :fragments, only: [] do
      resources :pages, only: [:edit]
    end

    resources :pages, only: [:update]
  end

  resources :sessions, only: [:create]
  resource :session, only: [:destroy]

  resources :pages, only: [:show], path: "/"

  root to: "pages#index"
end
