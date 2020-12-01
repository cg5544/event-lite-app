class EventsController < ApplicationController
  def index
    @events = Event.order('start_datetime ASC')
  end

  def create
    @event = Event.new(event_params)
    @event.start_datetime = parse_date
    if @event.save
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :start_datetime, :location)
  end

  def parse_date
    if event_params[:start_datetime].include? "-"
      event_params[:start_datetime]&.to_datetime
    else
      Date.strptime(event_params[:start_datetime], '%m/%d/%y')
    end
  end
end
