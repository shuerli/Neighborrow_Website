class ProfilesController < ApplicationController
  
  def new
    @profile = Profile.new 
  end  
  
  def create
    @profile = Profile.new(profile_params)
    @profile.save
  end  
 
  def show
    @account = Account.find(current_user.id)
    @profile = Profile.find_by_email(@account[:email])
  end  
    
  def edit
    @account = Account.find(current_user.id)
    @profile = Profile.find_by_email(@account[:email])
  end
    
  def update
    @account = Account.find(current_user.id)
    @profile = Profile.find_by_email(@account.email)
    
#    puts "profile_params[:avatar_url]"
#      
#    uploaded_io = profile_params[:avatar_url]
#    File.open(Rails.root.join("storage", uploaded_io.original_filename), 'wb') do |file|
#        file.write(uploaded_io.read)
#    end
      
    success = true
    profile_params.each do |key, val|
        if !Profile.where(:email => @profile.email).update_all(key => val)
          success = false
        end 
    end
    
    if profile_params[:avatar_url]
      if  profile_params[:avatar_url].content_type.in?(['image/png', 'image/jpg', 'image/jpeg'])
          @profile.avatar.attach(profile_params[:avatar_url])
      else
          flash[:error] = "You profile picture needs to be an image!"
          success = false
      end
    end
        
    if success
      redirect_to profile_path
    else
      render 'edit'
    end
    
  end
  
  
  private def profile_params
      params.require(:profile).permit(:email, :first_name, :middle_name, :last_name,:display_name, 
      :phone_number, :gender, :language, :country, :facebook, :gmail, :twitter, :avatar_url,:interest => [])
  end
  
end
