class EventsController < ApplicationController
  def index
  end

  def my_events
    @my_events = current_user.events_as_organiser
    @events_i_join = current_user.events_as_player
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @playgrounds = Playground.all
    @sports = Sport.all
    return if params[:sport_name].nil?

    @playgrounds = @playgrounds.select do |playground|
      playground.sport.name == params[:sport_name]
    end
  end

  def create
    @event = Event.new(event_params)
    @event.event_date = params[:event][:event_date]
    @event.start_time = params[:event][:start_time]
    @event.end_time = params[:event][:end_time]

    @event.organisator = current_user
    
    if @event.save
      Participation.create!(
        user: current_user,
        event: @event,
        status: :accepted
      )
      flash[:notice] = "Événement créé avec succès!"
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def search
    # Render all events near current user
    @near_events = Location
                   .near(current_user, 2) # le 10 devrait être variabilisé ?
                   # .flat_map { |location| location.events } idem que ligne suivante, marche pour tous les ittérateurs
                   .flat_map(&:events)

    @near_event_markers = @near_events.map do |event|
      {
        name: event.name,
        coordinates: event.coordinates,
        info_event_html: render_to_string(partial: "info_event", locals: { event: event }),
        marker_html: render_to_string(partial: "marker", locals: { event: event }),
        event_id: event.id
      }
    end

    @me_marker = {
      name: current_user.username,
      coordinates: {
        lat: current_user.latitude,
        lng: current_user.longitude
      },
      marker_html: render_to_string(partial: "me_marker")
    }

    @markers = @near_event_markers + [@me_marker]

    @events = Event.all
    return unless params[:query] # Early return

    search_results = Event.global_search(params[:query])
    if search_results.any?
      @events = search_results
    else
      @search_message = "Désolé, nous n'avons pas trouvé de résultat avec #{params[:query]}"
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :playground_id
    )
  end
end
