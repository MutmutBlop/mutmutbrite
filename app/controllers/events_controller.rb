class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
	before_action :is_admin, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def new
		@event = Event.new
	end

	def create
		@event = Event.new(user: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
		@event.save
		@event.picture.attach(params[:picture])

		if @event.save
			redirect_to event_path(@event)
			flash[:success] = "Your event has been successfully created"
		else
			render 'new'
		end
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])

		if @event.update(admin: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
			redirect_to event_path
			flash[:success] = "Your event has been successfully edited"
		else
			render :edit
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to root_path
	end

	def is_admin
		@event = Event.find(params[:id])

		if current_user != @event.admin
			flash[:alert] = "Access denied"
			redirect_to event_path
		end

	end

	def has_picture
	   if Event.picture.attached?
		   return true
	   else
		   render 'new'
		   flash[:alert] = "You must upload a picture"
	   end
  end

end
