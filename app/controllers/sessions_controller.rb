class SessionsController < ApplicationController
  def new
  end

  def create
    session = params.require(:session).permit(:email, :password)
    user = User.find_by email: session[:email]
    if user && user.authenticate(session[:password])
      if user.session_token.blank?
        user.regenerate_session_token
        user.save!
      end

      sign_in user
      flash[:success] = "You've been signed in."
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    current_user.update! session_token: nil
    sign_out
    flash[:success] = "You've been signed out."
    redirect_to root_path
  end
end
