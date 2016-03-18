Rails.application.routes.draw do
  root 'pages#index'

  get '/slack', to: 'slack#show'
  get '/slack/invite', to: 'slack#invite'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, except: [:destroy]
  get '/events', to: 'events#index'
  resources :events, except: [:show, :destroy]
  get '/directory', to: 'users#index'
  get '/join', to: 'users#new'

  get '/mailing_lists', to: 'mailing_list_subscriptions#index'
  get '/mailing_list_subscriptions/:list_id/delete', to: 'mailing_list_subscriptions#destroy', as: :delete_mailing_list_subscription
  get '/mailing_list_subscriptions/:list_id/new', to: 'mailing_list_subscriptions#new', as: :new_mailing_list_subscription

  scope :admin, as: 'admin' do
    get '/approval_queue', to: 'admin#approval_queue'
    get '/change_role/:id/:new_role', to: 'admin#change_role', as: 'change_role'
  end
end
