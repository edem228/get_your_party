class EventsController < ApplicationController
	before_action :authenticate_user!, except: :index
	before_action :find_envent, only: [:edit, :show, :update]
	def index
		@events = Event.order(:event_date).all.reverse
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
		@event = Event.find(params[:id])
		@participants = @event.participants

	end

	def participate
		Participation.create(user_id: current_user.id, event_id: params[:id])
		redirect_to participate_event_path(params[:id])
	end
	def price
		@price = Participation.cost / @event.participations.count

	end


	private
	
	def find_envent
		@event = Event.find(params[:id])
	end
	def event_params
		params.require(:event).permit(:name, :venue, :description, :address, :hour, :event_date, :places, :user_id)
	end
end
