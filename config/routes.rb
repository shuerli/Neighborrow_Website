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
  
  get '/settings', to: 'accounts#settings'
  
  resources:accounts do
      member do
          get :confirm_email
      end
  end
  
  resources:categories
  resources:items
  
	# Routes related to request manipulation, request history and relevant api
	get '/request_borrowed' => 'request#page_borrowed'
	get '/request_lended' => 'request#page_lended'
	get '/request' => 'request#show'
	post '/request' => 'request#create'
	put '/request' => 'request#update'

	# Routes related to feedback manipulation and relevant api
	post '/feedback/to-borrower' => 'feedback#create_toBorrower'
	post '/feedback/to-lender' => 'feedback#create_toLender'
	get '/feedback' => 'feedback#show'
    
  # Routes related to items in user dashboard
  get '/user_item' => 'user_items#show_all'
  get '/user_item_all' => 'user_items#get_data_all'

  get '/user_item/:id' => 'user_items#show' 
  get '/user_item/info/:id' => 'user_items#get_data'

  get '/user_item/edit/:id' => 'user_items#edit'
  get '/user_item/new' => 'user_items#new'



	post '/user_item' => 'user_items#create'
  put '/user_item/:id' => 'user_items#update'

	get '/404' => 'application#page_not_found'
    
end
