Rails.application.routes.draw do
  root 'pages#index'
  get '/login', to: 'user#login'
  post '/login/form', to: 'user#login_form'
  get '/logout', to: 'user#logout'
  get '/join', to: 'user#create'
end
