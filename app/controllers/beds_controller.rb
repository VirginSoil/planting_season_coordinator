class BedsController < ApplicationController
  def index
    make_sure_shes_got_a_bed
    @bed = valid_bed
    @width = @bed["width"]
    @depth = @bed["depth"]
    # response = Faraday.get("/api/v1/plantings/for_bed/#{@bed.id}")
    # plantings = JSON.parse(response.body)
    # [{"id"=>4, "bed_id"=>1, "plant_id"=>1, "planting_date"=>"2014-02-06", "estimated_harvest_date"=>"2014-02-06", "harvested"=>false, "created_at"=>"2014-02-07T00:55:06.173Z", "updated_at"=>"2014-02-07T00:55:06.173Z", "row"=>nil, "column"=>nil, "x_coord"=>1, "y_coord"=>2},
    #  {"id"=>5, "bed_id"=>1, "plant_id"=>1, "planting_date"=>"2014-02-06", "estimated_harvest_date"=>"2014-02-06", "harvested"=>false, "created_at"=>"2014-02-07T00:55:06.177Z", "updated_at"=>"2014-02-07T00:55:06.177Z", "row"=>nil, "column"=>nil, "x_coord"=>1, "y_coord"=>4}]
    # @taken_spots = plantings.map do |planting|
    #   [planting["x_coord"].to_s, planting["y_coord"].to_s]
    # end
    # @plant_names = ["Beets", "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kohlrabi", "Leeks", "Lettuce (Leaf)", "Onions, Green", "Onions, Dry(seed)", "Parsnips", "Peas", "Potatoes", "Radish", "Spinach", "Swiss Chard", "Turnips", "Beans", "Cantaloupe", "Corn", "Cucumbers, untrellised", "Eggplant", "Pepper", "Tomato", "Squash, Summer", "Squash, Winter", "Watermelons"]
    @plant_names = all_plant_names
    @all_plants = all_the_plants
    @taken_spots = [["0","0"], ["1","1"], ["2","2"], ["3","3"]]
  end

  def new
    @bed = Bed.new
    @current_user_id = cookies[:user_id]
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

  def valid_bed
    response = Faraday.get("http://localhost:8080/api/v1/beds/default_for_user/#{cookies[:user_id]}")
    JSON.parse(response.body)
  end

  def all_the_plants
    response = Faraday.get("http://localhost:8080/api/v1/plants")
    JSON.parse(response.body)
  end

  def all_plant_names
    all_the_plants.map {|plant| plant["name"] }
  end

end
