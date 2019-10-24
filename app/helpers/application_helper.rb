module ApplicationHelper
  def check_login
		if session[:user_info].nil? then
			return false
    else
      return true
		end
	end
end
