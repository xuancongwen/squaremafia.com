Rails.application.routes.draw do
  root 'pages#index'

  get '/slack', to: 'slack#show'
  get '/slack/invite', to: 'slack#invite'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/directory', to: 'directory#show'

  resource :user
end
