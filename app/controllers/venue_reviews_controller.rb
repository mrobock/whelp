 class VenueReviewsController < ApplicationController
  before_action :set_venue_review, only: [:show, :edit, :update, :destroy]

  # GET /venue_reviews
  # GET /venue_reviews.json
  def index
    @venue_reviews = VenueReview.all
    redirect_to '/venues'
  end

  # GET /venue_reviews/1
  # GET /venue_reviews/1.json
  def show
  end

  # GET /venue_reviews/new
  def new
    @venue_review = VenueReview.new
  end

  # GET /venue_reviews/1/edit
  def edit
  end

  # POST /venue_reviews
  # POST /venue_reviews.json
  def create
    @venue_review = VenueReview.new(venue_review_params)

    respond_to do |format|
      if @venue_review.save
        format.html { redirect_to @venue_review, notice: 'Venue review was successfully created.' }
        format.json { render :show, status: :created, location: @venue_review }
      else
        format.html { render :new }
        format.json { render json: @venue_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venue_reviews/1
  # PATCH/PUT /venue_reviews/1.json
  def update
    respond_to do |format|
      if @venue_review.update(venue_review_params)
        format.html { redirect_to @venue_review, notice: 'Venue review was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue_review }
      else
        format.html { render :edit }
        format.json { render json: @venue_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venue_reviews/1
  # DELETE /venue_reviews/1.json
  def destroy
    @venue_review.destroy
    respond_to do |format|
      format.html { redirect_to venue_reviews_url, notice: 'Venue review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue_review
      @venue_review = VenueReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_review_params
      params.require(:venue_review).permit(:review, :user_id, :venue_id)
    end
end
