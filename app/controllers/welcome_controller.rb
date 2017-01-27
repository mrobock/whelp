class WelcomeController < ApplicationController
# class WelcomeController < ActionController::Base
  layout "welcome", only: [:index]

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

  def map_locations
     draw_map(Venue.all)
  end

  def draw_map(venues)
    @hash = Gmaps4rails.build_markers(venues) do |venue, marker|
      marker.lat(venue.latitude)
      marker.lng(venue.longitude)
      marker.infowindow('<a href="venues/' + venue.id.to_s + '
      ">' + venue.name + '</a>')
    end
    render json: @hash.to_json
  end
end
