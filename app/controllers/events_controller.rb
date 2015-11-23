class EventsController < ApplicationController
	before_action :authenticate_user!, except: :index
	before_action :find_envent, only: [:edit, :show, :update, :destroy]

	def index
		@events = Event.order(:event_date).all
	end
	
	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.build(event_params)
		if	@event.save
			redirect_to @event
		else
			render 'new'
		end
	end
	def edit
	end

	def update
		if @event.update(event_params)
			redirect_to @event
		else
			render 'edit'
		end
	end

	def show
		@user = current_user
		@participants = @event.participants
	end
	def destroy
		if @event.destroy
			redirect_to root_path
		end
	end

	def participate
		Participation.create(user_id: current_user.id, event_id: params[:id])
		redirect_to participate_event_path(params[:id])
	end

	def price
		@price = Event.cost / @event.participations.count
	end

	private
	
	def find_envent
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:name, :venue, :description, :address, :hour, :event_date, :places, :user_id)
	end
end
