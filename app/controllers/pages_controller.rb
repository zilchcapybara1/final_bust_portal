class PagesController < ApplicationController
	def index
	end

	def show_login
	end

	def new_login
		@username = params[:username]
		@password = params[:password]

		@u = User.find_by(username: @username)

		if @u && @u.authenticate(@password) then
			session[:user_info] = @u
		end

		redirect_to "/"
	end

	def logout
		session[:user_info] = nil

		redirect_to "/"
	end
end
