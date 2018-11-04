Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root  'pages#main', as: 'home'
  get   '/login',   to: 'sessions#login', as: 'login'
  post  '/login',   to: 'sessions#create'
  delete    '/logout',  to: 'sessions#destroy'
  get   '/temp',     to: 'pages#temp'
  resources:accounts
end
