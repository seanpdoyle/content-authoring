Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :fragments, only: [] do
      resources :pages, only: [:edit]
      resources :translations, only: [:edit], constraints: { id: /[^\/]+/ }
    end

    resources :pages, only: [:update]
    resources :translations, only: [:create]
  end

  resources :sessions, only: [:create]
  resource :session, only: [:destroy]

  resources :examples, only: [:index]
  resources :pages, only: [:show], path: "/"

  root to: "pages#index"
end
