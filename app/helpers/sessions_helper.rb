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
    if instance_variable_defined? :@current_user
      @current_user
    else
      user = User.find_by \
        id: session[:user_id],
        session_token: session[:session_token]
      @current_user = user || NullUser.instance
    end
  end
end
