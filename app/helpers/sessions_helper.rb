module SessionsHelper
    # Logs in the given user. 
    def log_in(user) 
        session[:user_id] = user.id 
    end 
    # Remembers a user in a persistent session. 
    def remember(user)
        user.remember 
        cookies.permanent.encrypted[:user_id] = user.id 
        cookies.permanent[:remember_token] = user.remember_token 
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
    # Forgets a persistent session.  
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    # Logs out the current user.
    def log_out
        forget(current_user)
        reset_session
        @current_user = nil
    end
    # Returns true if the given user is the current user. 
    def current_user?(user) 
        user && user == current_user 
    end
    def current_shop?(shop) 
        shop && shop == current_shop
    end
    # Stores the URL trying to be accessed.L10.31
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

end
