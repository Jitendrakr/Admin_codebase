class EventsController < ApplicationController
	def new
    # if current_admin.present?
    @event = Event.new
    # else
      # flash[:error] = 'please login as Admin'
      # redirect_to root_path
    # end
end

def create
	@event = Event.new(event_params)
	if @event.save
		redirect_to events_path , :notice => 'Event Created'
	else
		render 'new'
	end
end

def view_more
	@events =Event.all
	@query=Query.new
end

def index
	# if current_admin.present?

		if params[:name].present?
			@events=   Event.search( params[:name]).paginate(:page => params[:page], :per_page => 25).order('created_at DESC')
		elsif params[:event_type].present?
			@events=   Event.search2( params[:event_type]).paginate(:page => params[:page], :per_page => 25).order('created_at DESC')
		else
			@events=Event.paginate(:page => params[:page], :per_page => 25).order('created_at DESC')
		end
		if request.xhr? != 0
			render  layout: 'application'
		else
			render @events
		end
	# else
	# 	flash[:error] = 'please login as Admin'
	# 	redirect_to root_path
	# end
 end

def edit
	if current_admin.present?
		@event = Event.find(params[:id])
	else
		flash[:error] = 'please login as Admin'
		redirect_to root_path
	end
end

def update
	@events = Event.all
	@event= Event.find(params[:id])
	if @event.update_attributes(event_params)
		redirect_to events_path , :notice => 'Event Updated'
	else
		render 'edit'
	end
end

def destroy
	if current_admin
		@event= Event.find(params[:id])
		@event.destroy
		redirect_to events_path , :notice => 'Event Deleted'
	else
		redirect_to root_path , :notice=> 'please login as Admin'
	end
end

def show
	@query=Query.new
	if params[:format].present?
		@event=Event.find(params[:format])
	else
		@event=Event.find(params[:id])
	end
end

def multiple_delete
	if Event.where(:id => params[:event_ids]).destroy_all
		redirect_to events_path , :notice=>' Successfully deleted events'
	end
end

private
def event_params
	params.require(:event).permit!
end
end
