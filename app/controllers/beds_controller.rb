class BedsController < ApplicationController
  def index
    @beds = current_users_beds
    session[:default_bed] ||= valid_bed['id']
  end

  def show
    # raise params.inspect
    make_sure_shes_got_a_bed
    @bed = params[:bed] && params[:bed][:bed_id] ? show_bed : default_bed
    @width = @bed["width"]
    @depth = @bed["depth"]
    @plant_names = all_plant_names
    @all_plants = all_the_plants
    @plantings = plantings_for_bed(@bed)
    @taken_spots = taken(@bed)
  end

  def new
    @bed = Bed.new
    @current_user_id = cookies[:user_id]
  end

  def edit
    response = Faraday.get("http://localhost:8080/api/v1/beds/#{(params[:id])}")
    attrs = JSON.parse(response.body)
    @bed = Bed.new(attrs)
    @current_user_id = cookies[:user_id]
  end

  def update
    response = Faraday.put("http://localhost:8080/api/v1/beds/#{(params[:id])}") do |req|
      request = params
      req.body = params
    end
    redirect_to beds_path, :notice => "Got er done!"
  end

  def create
    response = Faraday.post('http://localhost:8080/api/v1/beds') do |req|
      request = params
      req.body = params
    end

    if response.status == 201
      flash[:success] = "YOU WIN!"
      redirect_to root_path
    else
      @bed = Bed.new
      flash[:error] = "You fargin' failed buddy."
      render 'beds/new', :notice => "Error Will Robinson!"
    end
  end

  private

  def make_sure_shes_got_a_bed
    unless current_users_beds.length > 0
      redirect_to new_bed_path, :notice => "Please create a bed first!"
    end
  end

  def current_users_beds
    response = Faraday.get("http://localhost:8080/api/v1/beds/for_user/#{cookies[:user_id]}")
    JSON.parse(response.body)
  end

  def default_bed
    response = Faraday.get("http://localhost:8080/api/v1/beds/default_for_user/#{cookies[:user_id]}")
    JSON.parse(response.body)
  end

  def show_bed
    response = Faraday.get("http://localhost:8080/api/v1/beds/#{params[:bed][:bed_id]}")
    JSON.parse(response.body)
  end

  def all_the_plants
    response = Faraday.get("http://localhost:8080/api/v1/plants")
    JSON.parse(response.body)
  end

  def all_plant_names
    all_the_plants.map {|plant| plant["name"] }
  end

  def plantings_for_bed(bed)
    response = Faraday.get("http://localhost:8080/api/v1/plantings/for_bed/#{bed['id']}")
    plantings = JSON.parse(response.body)
  end

  def taken(bed)
    plantings_for_bed(bed).map do |planting|
      [planting["x_coord"].to_s, planting["y_coord"].to_s]
    end
  end

end
