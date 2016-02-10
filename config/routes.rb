Rails.application.routes.draw do
  root 'pages#index'

  scope '/user'  do
    post '/login', to: 'user#login'
    get '/logout', to: 'user#logout'
    post '/create', to: 'user#create'
  end
end
