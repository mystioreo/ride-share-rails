class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def create
    available_drivers = Driver.select { |driver| driver.is_available? }
    driver = available_drivers.sample
    trip_hash = {driver_id: driver.id, passenger_id: params[:passenger_id].to_i, date: DateTime.now, cost: rand(200..5000)}
    @trip = Trip.new(trip_hash)
    @trip.save
    redirect_to trip_path(@trip.id)
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end


  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    return params.require(:trip).permit(:rating, :date, :cost)
  end

end
