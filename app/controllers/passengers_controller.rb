class PassengersController < ApplicationController
  before_action :set_passenger, only: [:show, :edit, :update, :destroy]

  def index
    @passengers = Passenger.all
  end

  def show
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passengers_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @passenger.update(passenger_params)
    redirect_to passenger_path(@passenger.id)
  end

  def destroy
    @passenger.destroy
    redirect_to passenger_path
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

  def set_passenger
    @passenger = Passenger.find(params[:id])
  end

end