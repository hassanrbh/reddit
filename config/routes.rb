Rails.application.routes.draw do
  root to: "subs#index"
  devise_scope :user do
    # redirect signing out users back to sign-in
    get "login", to: "devise/sessions#new"
    get "register", to: "devise/registrations#new"
  end
  devise_for :users
  resources :subs
end
