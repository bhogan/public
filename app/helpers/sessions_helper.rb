module SessionsHelper
  
  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
    @current_user
  end
  
  def current_user?(user)
    current_user == user  
  end
  
  
  def get_cookie(c_val)
    cookies[c_val]
  end
  
   def logged_in?
    !current_user.nil?
  end
  
  
end
