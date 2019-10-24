class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
    @open_flights = []
    @closed_flights = []

    @flights.each do |f|
      if f.seats.length >= f.capacity then
        @closed_flights.append(f)
      else
        @open_flights.append(f)
      end
      @result = Seat.all.group(:seat_class_id).count

      @chart_data = {}

      @result.each do |k ,v |
          @chart_data[SeatClass.find(k).class_name] =v
        end
      end
    end


  # GET /flights/1
  # GET /flights/1.json
  def show
    Leaflet.tile_layer = "http://{s}.tile.cloudmade.com/YOUR-CLOUDMADE-API-KEY/997/256/{z}/{x}/{y}.png"
# You can also use any other tile layer here if you don't want to use Cloudmade - see http://leafletjs.com/reference.html#tilelayer for more
Leaflet.attribution = "Your attribution statement"
Leaflet.max_zoom = 18

  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.require(:flight).permit(:departure, :arrival, :destination, :baggage_allowance, :capacity)
    end
  end
