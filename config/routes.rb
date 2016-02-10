Rails.application.routes.draw do
  root 'pages#index'

  get '/slack', to: 'slack#show'
  get '/slack/invite', to: 'slack#invite'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, except: [:destroy]
  get '/directory', to: 'users#index'
  get '/join', to: 'users#new'
end
