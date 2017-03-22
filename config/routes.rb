Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  root to: 'users#home'
  
  get '/spot-searching/new', to: 'searching#new'
  get '/spot-searching/results', to: 'searching#index'

  resources :spaces
  resources :searches

  devise_for :users, controllers: { sessions: "users/sessions", :registrations => "users/registrations" }

  devise_scope :user do 
    get '/sign_up', to: 'users#home'
  end

end
