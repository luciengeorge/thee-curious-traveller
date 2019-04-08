class TripsController < ApplicationController
  before_action :find_trip, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!
  def index
    @trips = Trip.all
  end

  def show
  end

  def new
    @trip = Trip.new
    @trip.photos.build
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      params[:trip][:photos_attributes]['0'][:url].each do |url|
        @trip.photos.create(url: url)
      end
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @trip.update(trip_params)
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:title, :description, :destination, :price, photos_attributes: [:url])
  end
end
