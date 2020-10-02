Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :admin do
    resources :translations, only: :create
  end

  resources :sessions, only: :create
  resource :session, only: :destroy

  root to: "marketings#index"
end
