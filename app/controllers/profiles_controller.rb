class ProfilesController < ApplicationController
  
  def new
    @profile = Profile.new 
  end  
  
  def create
    @profile = Profile.new(profile_params)
    @profile.save
  end  
 
  def show
    @account = Account.find(params[:id])
    @profile = Profile.find_by_email(@account[:email])
  end  
    
  def edit
    @account = Account.find(params[:id])
    @profile = Profile.find_by_email(@account[:email])
  end
    
  def update
    puts "@@@@@@@@@@@@@@@@@@@@I am in UPDATE @@@@@@@@@@@@@@@@@@@@@@@@@@"
    puts "***************profile_params[:email]*****************", profile_params[:email]
    @account = Account.find(params[:id])
    puts "****************@account[:email]****************", @account[:email]
    @profile = Profile.find_by_email(@account[:email])
    puts "*****************@profile[:email]***************", @profile.email
    puts  @profile.created_at
    puts  @profile.display_name
      
    if @profile.update(email: '123@gmail.com')
      puts "*****************GOOD***************"
      redirect_to @profile
    else
      puts "*****************BAD***************"
      render 'edit'
    end
  end
  
 
  
  private def profile_params
      params.require(:profile).permit(:email, :first_name, :middle_name, :last_name,:display_name, 
      :phone_number, :gender, :language, :country, :facebook, :gmail, :twitter, :avatar_url, :interest)
  end
  
end