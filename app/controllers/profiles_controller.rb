class ProfilesController < ApplicationController
  
  def edit
    
  end
  
  def update
    
  end
  
  private def profile_params
    params.require(:profile).permit(:email, :first_name, :middle_name, :last_name,:display_name, 
      :phone_number, :gender, :languages, :country, :facebook, :gmail, :twitter, :avatar_url, :interest)
  end
  
  
end
