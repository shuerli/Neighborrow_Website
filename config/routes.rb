Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root  'pages#main', as: 'home'
  get '/index', to: 'pages#main'
  
  #routes related to login and sign up
  get   '/login',   to: 'sessions#login', as: 'login'
  get 'auth/:provider/callback', to: 'sessions#create_auth'
  post  '/login',   to: 'sessions#create'
  delete    '/logout',  to: 'sessions#destroy'

  get    '/signup',  to: 'accounts#new'
  post    '/signup',  to: 'accounts#create'
  
  get 'auth/failure', to:redirect('/login')
  get   '/temp',     to: 'pages#temp'
  get '/borrow',    to: 'item#borrow'
  
	get '/sidebar_intialize' => 'accounts#userSidebar_Info'
	get '/userdashboard_initialize' => 'accounts#userDashboard_Info'

	# Routes to handlers related to search-result page
	get '/result' => 'items#showResult'
	get '/result_api' => 'items#generateResult'	

  resources:profiles
  resources:public_profiles
  resources:pays
  
  get '/pays/:id/editTwo', to: 'pays#editTwo', as: :pay_editTwo
  patch  '/pays/:id', to: 'pays#updateTwo', as: :pay_updateTwo
  put    '/pays/:id',  to: 'pays#updateTwo'
  
  
	# Routes to dashboards
	get '/user' => 'dashboards#user'
	#get '/admin' => 'dashboards#admin'

	get '/admin_reports' => 'dashboard#show_report'
  
  get '/resendConfirmation', to:'accounts#resendConfirmation'
  resources:accounts do
      post :resendConfirmation, :on => :collection
      member do
          get :confirm_email
      end
  end
  
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources:categories

  get '/category/departments' => 'categories#departments'
  get '/category/department/category_names' => 'categories#by_department'
  get '/category/id' => 'categories#find_id'
  resources:items
  
	# Routes related to request manipulation, request history and relevant api
	get '/request_borrowed' => 'request#page_borrowed'
	get '/request_lended' => 'request#page_lended'
    get '/request' => 'request#show'
    get '/request/new/:id' => 'request#complete'
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

  put '/user_item' => 'user_items#destroy'

  get '/user_items/new' => 'user_items#new'
  # route for creating new item
	post '/user_item' => 'user_items#create'

  get '/user_item/edit/:id' => 'user_items#edit'
  put '/user_item/edit' => 'user_items#update'
  get '/address' => 'user_items#get_address'
  post '/address_new' => 'user_items#add_address'
  get '/get_borrower' => 'user_items#find_borrower'

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
      get '/Error' => 'pages#error'

      get '/sitemap' => 'sitemap#sitemap'
  
  
      # For file transfer
  post '/media_contents' => 'media_contents#create'
  get '/media_contents' => 'media_contents#find_url'

	get '/report' => 'reports#index'
	post '/report' => 'reports#create'



end

