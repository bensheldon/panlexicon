module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  def sign_out
    session.delete(:user_id)
    session.delete(:session_token)
  end

  def current_user
    @current_user ||= User.find_by \
      id: session[:user_id],
      session_token: session[:session_token]
  end
end
