# frozen_string_literal: true

module Managers
  class EventsController < Managers::ApplicationController
    def index
      events      = Event.all.order(event_name: :asc)
      event_views = EventView.collection(events)

      render :index, locals: { events: event_views }
    end

    def new
      event = Event.new

      render :new, locals: { event: }
    end

    def create
      create_params = event_params.transform_values(&:squish)
      event = Event.new(create_params)

      if event.save
        redirect_to managers_events_path, notice: "Event: #{event.event_name} was successfully created."
      else
        render :new, locals: { event: }
      end
    end

    def edit
      event = Event.find(params[:id])

      render :edit, locals: { event: }
    end

    def update
      update_params = event_params.transform_values(&:squish)
      event         = Event.find(params[:id])

      if event.update(update_params)
        redirect_to managers_events_path, notice: "Event: #{event.event_name} was successfully updated."
      else
        render :edit, locals: { event: }
      end
    end

    def destroy
      event = Event.find(params[:id])
      name  = event.event_name
      event.destroy

      redirect_to managers_events_path, notice: "Event: #{name} was successfully deleted."
    end

    private

    def event_params
      params.require(:event).permit(:event_name, :event_description)
    end
  end
end
