Rails.application.routes.draw do
  root 'pages#index'
  get '/login', to: 'user#login'
  post '/login/form', to: 'user#login_form'
  get '/logout', to: 'user#logout'
  get '/join', to: 'user#create'
  get '/directory', to: 'user#directory'
  get '/profile', to: 'user#profile'
  get '/slack', to: 'slack#show'
  get '/slack/invite', to: 'slack#invite'
end
