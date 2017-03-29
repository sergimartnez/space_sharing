Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  root to: 'users#home'
  
  post '/searches/new_searching', to: 'searches#searching'
  get '/searches', to: 'searches#results'

  resources :spaces
  resources :searches, only: [:show, :new, :create, :update, :edit, :update]

  get '/searches/my-searches', to: 'searches#my_searches'

  devise_for :users, controllers: { sessions: "users/sessions", :registrations => "users/registrations" }

  devise_scope :user do 
    get '/sign_up', to: 'users#home'
  end

  get '/shared-rental/view', to: 'shared_rentals#view'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :chatrooms, param: :slug
  resources :messages

  get '/users/:id', to: 'users#show'

end
