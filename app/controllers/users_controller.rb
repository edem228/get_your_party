class UsersController < ApplicationController

	def show
		@user = current_user
		@events = @user.events.order(:created_at)
	end


	def index
		
	end




end

