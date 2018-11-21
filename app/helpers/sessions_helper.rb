module SessionsHelper
    # Logs in
    def log_in(user)
        session[:user_id] = user.id
    end
   
    # Logs out
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
    
    # Returns the current logged-in user (if any).
    def current_user
        if session[:user_id]
            @current_user ||= Account.find_by(id: session[:user_id])
        end
    end
    
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
    
    # Returns true if the user is logged in as UserID, false otherwise.
    def logged_in_as_user? (user_id)
        if current_user.nil?
          return false
        elsif current_user.id != user_id
          return false
        else
          return true
        end
    end
    
end
