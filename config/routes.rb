Rails.application.routes.draw do
  default_url_options :host => 'localhost', :port => 3000

  root to: "subs#index"

  devise_scope :user do
    # redirect signing out users back to sign-in
    get "login", to: "devise/sessions#new",constraints: { subdomain: 'app' }
    get "register", to: "devise/registrations#new", constraints: { subdomain: 'app'}
  end

  devise_for :users
  resources :users, :only => [:show]
  resources :subs do
    member do
      post "subscribe"
    end
    collection do 
      post "search"
    end
  end
  resources :posts, except: [:index] do
    member do
      post "upvote"
      post "downvote"
    end
  end
  resources :comments, :only => [:create,:show] do 
    member do 
      post "upvote"
      post "downvote"
    end
  end
end
