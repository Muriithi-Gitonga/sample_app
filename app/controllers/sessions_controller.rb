class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      # login the user and direct to users show page
      if @user.activated?
        forwarding_url = session[:forwading_url]
        reset_session #reset a session immediately before logging in so that the attackers desired  is get cleared and freshly created id ends in session hash
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        log_in @user
        flash[:success] = "Welcome #{@user.name}"
        redirect_to forwarding_url || @user
      else
        message = "Account not activated"
        message += "Check your email for the activation"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # create an error message
      flash.now[:danger] = "Invalid email/password combination"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
