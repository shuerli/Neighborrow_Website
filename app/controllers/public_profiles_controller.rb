class PublicProfilesController < ApplicationController
  
  def show
      @account = Account.find(params[:id])
      @profile = Profile.find_by_email(@account[:email])
        
      @borrower_rate = ActiveRecord::Base.connection.exec_query("SELECT AVG(Feedback_to_borrowers.rate) AS borrower_avg FROM Requests,Feedback_to_borrowers WHERE Requests.borrower = '"+@account.email+"' AND Requests.id = Feedback_to_borrowers.request_id;")
      @items = Iten.where(:owner => @account.email)
  end  
  
  
end
