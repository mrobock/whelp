class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update]

  # GET /rsvps
  # GET /rsvps.json
  def index
    @rsvps = Rsvp.all
    redirect_to '/events'
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
  end


  # GET /rsvps/1/edit
  def edit
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
      @rsvp = Rsvp.new(rsvp_params)

      respond_to do |format|
        if @rsvp.event.date >= DateTime.now && @rsvp.save
          format.html { redirect_to '/events/' + rsvp_params[:event_id].to_s, notice: 'RSVP was successfully created.' }
          format.json { render :show, status: :created, location: @rsvp }
        elsif @rsvp.event.date < DateTime.now
          format.html { redirect_to '/events/' + rsvp_params[:event_id].to_s, alert: 'RSVP cannot be created.' }
          format.json { render json: @rsvp.errors, status: :unprocessable_entity }
        else
          format.html { render :new }
          format.json { render json: @rsvp.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /rsvps/1
  # PATCH/PUT /rsvps/1.json
  def update
    respond_to do |format|
      if @rsvp.event.date >= DateTime.now && @rsvp.update(rsvp_params)
        format.html { redirect_to '/events/' + rsvp_params[:event_id], notice: 'RSVP was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsvp }
      elsif @rsvp.event.date < DateTime.now
        format.html { redirect_to '/events/' + rsvp_params[:event_id].to_s, alert: 'RSVP cannot be updated.' }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      else
        format.html { render :edit }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsvps/1
  # DELETE /rsvps/1.json
  def destroy
    @delete_rsvp = Rsvp.find_by(user_id: current_user.id, event_id: params[:id])
    respond_to do |format|
      if @delete_rsvp.event.date >= DateTime.now && @delete_rsvp.destroy
        format.html { redirect_to '/events/' + params[:id], notice: 'RSVP was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to '/events/' + params[:id].to_s, alert: 'RSVP cannot be destroyed.' }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsvp
      @rsvp = Rsvp.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsvp_params
      params.require(:rsvp).permit(:status, :user_id, :event_id)
    end
end
