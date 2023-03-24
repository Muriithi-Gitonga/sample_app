module SessionsHelper
     # Log in the given user
    def log_in user
        session[:user_id] = user.id
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

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by_id(session[:user_id])
        end
    end

    # Returns true if the user is logged in, false otherwise
    def logged_in?
        !current_user.nil?
    end

    def log_out
        reset_session
        @current_user = nil
    end
end
