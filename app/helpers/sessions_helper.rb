module SessionsHelper
     # Log in the given user
    def log_in user
        session[:user_id] = user.id
        session[:session_token] = user.session_token
    end

    # returns the current user logged-in if any
    # def current_user
    #     if session[:user_id]
    #         #  this is if the current user appears multiple time on a page and we do not want to hit the database muliple times
    #         # if @current_user.nil?
    #         #     @current_user = User.find_by_id(session[:user_id])
    #         # else 
    #         #     @current_user
    #         # end
    #         # we can rewrite this as follows
    #                         # this is called memoization the practice of remembering variable assignments from one method invocation to another
    #         @current_user = @current_user || User.find_by_id(session[:user_id])
                # A series of || expressions terminates after the first true expression is true - This practice is known as short-circuit evaluation
    #     end
    # end

    # Remembers a user in a persistent session
    def remember user
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def current_user
        if (user_id = session[:user_id])
            user = User.find_by_id(user_id)
            if user && session[:session_token] == user.session_token
                @current_user ||= user
            end
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by_id(user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # Return true if the given user is the current user

    def current_user?(user)
        user&. == current_user
    end

    # Returns true if the user is logged in, false otherwise
    def logged_in?
        !current_user.nil?
    end

    # forget a persistent session
    def forget user
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end


    def log_out
        forget current_user
        reset_session
        @current_user = nil
    end

    def store_location
        session[:forwading_url] = request.original_url if request.get?
    end
end
