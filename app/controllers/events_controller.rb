class EventsController < ApplicationController
  layout "index-show", only: [:show, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event_review = EventReview.new
    @event_reviews = EventReview.where(event_id: @event.id)

    # Set up blank comment and list of comments
    @comment = Comment.new
    @comments = Comment.where(event_id: @event.id)

    # Finds user's current rating if existing or creates new blank rating. Also finds rating average
    rating = Rating.where(user: current_user, event: @event)
    if rating.length >= 1
      @rating = rating[0]
    else
      @rating = Rating.new
    end
    # @avg_rating = Rating.where(event: @event).average("rating").to_f.round(2)
    # @count_rating = Rating.where(event: @event).count

    # RSVP
    if user_signed_in?
      @remove_rsvp = Rsvp.find_by(event_id: params[:id], user_id: current_user.id)
    end
  end

  def rating_update
    @avg_rating = {average: Rating.where(event_id: params[:event_id]).average("rating").to_f.round(2), count: Rating.where(event_id: params[:event_id]).count}
    render json: @avg_rating.to_json
  end

  # GET /events/new
  def new
    @venues_for_select = Venue.all.map do |venue|
      [venue.name, venue.id]
    end
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    if current_user == @event.user
      @event = Event.find(params[:id])
      @venues_for_select = Venue.all.map do |venue|
        [venue.name, venue.id]
      end
    else
      redirect_to 'events'
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html {
          @venues_for_select = Venue.all.map do |venue|
            [venue.name, venue.id]
          end
          render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if current_user != @event.user
      redirect_to 'events'
    end
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_events
    @events = Event.all
    events_array = []
    @events.each do |event|
      events_array << { id: event.id, title: event.name, start: event.date, url: Rails.application.routes.url_helpers.event_path(event.id) }
    end
    render :json => events_array.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :date, :venue_id, :description, :user_id, :image)
    end
end
