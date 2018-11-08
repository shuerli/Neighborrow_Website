Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root  'pages#main', as: 'home'
  get '/index', to: 'pages#main'
  get   '/login',   to: 'sessions#login', as: 'login'
  post  '/login',   to: 'sessions#create'
  delete    '/logout',  to: 'sessions#destroy'
  get   '/temp',     to: 'pages#temp'
  
  get '/borrow',    to: 'item#borrow'
  resources:accounts
  resources:categories
  resources:items
  
	# Routes related to request manipulation, request history and relevant api
	get '/request_borrowed' => 'request#page_borrowed'
	get '/request_lended' => 'request#page_lended'
	get '/request' => 'request#show'
	post '/request' => 'request#create'
	put '/request' => 'request#update'
    
    
end
