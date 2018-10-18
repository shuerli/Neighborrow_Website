Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root  'pages#main', as: 'home'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete    '/logout',  to: 'sessions#destroy'
  
  resources:accounts
end
