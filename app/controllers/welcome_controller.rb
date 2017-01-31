class WelcomeController < ApplicationController
# class WelcomeController < ActionController::Base
  layout "welcome", only: [:index]
  layout "application_search", only: [:search]

  def index
    if !params[:search_params].nil? && !params[:search_params].to_s.strip.empty?
      @venue_results = Venue.search(params[:search_params])
      @event_results = Event.search(params[:search_params])
      @search_results = @venue_results + @event_results
    elsif !params[:search_params].nil? &&   params[:search_params].to_s.strip.empty?
      flash.now[:alert] = "You must type something in the search bar."
      @search_results = nil
    end

    @venues = Venue.all
    @events = Event.all

    @upcoming = Event.where('date > ?', DateTime.now).order(:date).limit(9)
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

  def search
    if !params[:search_params].nil? && !params[:search_params].to_s.strip.empty?
      @query = params[:search_params]
      @user_results = User.search(@query)
      @venue_results = Venue.search(@query)
      @event_results = Event.search(@query)
      @search_results = @venue_results + @event_results + @user_results
    elsif !params[:search_params].nil? &&   params[:search_params].to_s.strip.empty?
      flash.now[:alert] = "You must type something in the search bar."
      @search_results = nil
    end
  end
end
