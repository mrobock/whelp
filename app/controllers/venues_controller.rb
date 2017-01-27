class VenuesController < ApplicationController
  layout "index-show", only: [:show, :index]
  before_action :set_venue, only: [:show, :edit, :update, :destroy, :rate]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
  end

  def map_location
    @venue = Venue.find(params[:venue_id])
    @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
      marker.lat(venue.latitude)
      marker.lng(venue.longitude)
      marker.infowindow("<em>" + venue.name + "</em>")
    end
    render json: @hash.to_json
  end


  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue_review = VenueReview.new
    @venue_reviews = VenueReview.where(venue_id: @venue.id)

    @comment = Comment.new
    @comments = Comment.where(venue_id: @venue.id)

    # Finds user's current rating if existing or creates new blank rating. Also finds rating average
    rating = Rating.where(user: current_user, venue: @venue)
    if rating.length == 1
      @rating = rating[0]
    else
      @rating = Rating.new
    end
    # avg_rating(@venue)
    # @count_rating = Rating.where(venue: @venue).count
  end

  # def avg_rating(venue)
  #   if params[:venue_id].nil?
  #     @avg_rating = Rating.where(venue: venue).average("rating").to_f.round(2)
  #   else
  #     @avg_rating = Rating.where(venue_id: params[:venue_id]).average("rating").to_f.round(2)
  #   end
  # end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
    if current_user != @venue.user
      redirect_to 'venues'
    end
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    if current_user != @venue.user
      redirect_to 'venues'
    end
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rate
    respond_to do |format|
      if @venue.update(rating: params[:rating])
        format.html { redirect_to @venue, notice: 'Rating was successfully submitted.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :description, :street_1, :street_2, :city, :state, :zip, :user_id, :image)
    end


end
