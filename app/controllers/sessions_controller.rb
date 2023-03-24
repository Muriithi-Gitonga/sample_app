class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # login the user and direct to users show page
      reset_session #reset a session immediately before logging in so that the attackers desired is get cleared and freshly created id ends in session hash
      log_in user
      redirect_to user
    else
      # create an error message
      flash.now[:danger] = "Invalid email/password combination"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  
end
