class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
    @ability = Ability.new(current_user)
  end

  def show
    @user = User.find(params[:id])
    @user_events = Event.where(user_id: params[:id])
    @user_venues = Venue.where(user_id: params[:id])
    @user_rsvps = Rsvp.where(user_id: params[:id])
    @ability = Ability.new(current_user)
  end

  def edit
    @user = User.find(params[:id])
    @ability = Ability.new(current_user)
  end

  def update
    @user = User.find(params[:id])
    @ability = Ability.new(current_user)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_index_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.soft_delete

    respond_to do |format|
      format.html { redirect_to users_index_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :street_1, :street_2, :city, :state, :zip, :image)
    end

end
