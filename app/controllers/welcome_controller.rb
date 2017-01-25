class WelcomeController < ApplicationController

  def map_locations
    venues = Venue.all # TODO
    @hash = Gmaps4rails.build_markers(venues) do |venue, marker|
      marker.lat(venue.latitude)
      marker.lng(venue.longitude)
      marker.infowindow("<em>" + venue.name + "</em>")
    end
    render json: @hash.to_json
  end

  def index
    if !params[:search_params].nil? && !params[:search_params].to_s.strip.empty?
      @venue_results = Venue.search(params[:search_params])
      @event_results = Event.search(params[:search_params])
      @search_results = @venue_results + @event_results
    elsif !params[:search_params].nil? &&   params[:search_params].to_s.strip.empty?
      flash.now[:alert] = "You must type something in the search bar."
      @search_results = nil
    end
  end

end
