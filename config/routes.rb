Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root  'pages#main', as: 'home'
  get '/index', to: 'pages#main'
  
  #routes related to login and sign up
  get   '/login',   to: 'sessions#login', as: 'login'
  get 'auth/:provider/callback', to: 'sessions#create_auth'
  post  '/login',   to: 'sessions#create'
  delete    '/logout',  to: 'sessions#destroy'

  get 'auth/failure', to:redirect('/login')
  get   '/temp',     to: 'pages#temp'
  get '/borrow',    to: 'item#borrow'
  get '/settings', to: 'accounts#settings'
  

  resources:profiles

  
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

	# Routes for redirecting to system pages (error handler)
	get '/404' => 'application#page_not_found'

	# Routes for searching (public access granted)
	get '/search/keyword_prompt' => 'items#keyword_prompt'
	#get '/search/geo/:lon/:lat'
    
    #routes related to public item show page
    get '/search_show', to: 'item#search_show', as: 'search_show'
    
    #Routes for testing purposes
      get   '/temp',     to: 'pages#temp'
      get   '/termsOfService', to:'pages#termsOfService'
      get   '/privacyPolicy', to:'pages#privacy'
      get   '/contactUs', to:'pages#contactus'
      get   '/aboutUs',  to:'pages#about'
      get   '/FAQ',  to:'pages#FAQ'
      get   '/team',  to:'pages#team'
end
