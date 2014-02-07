class BedsController < ApplicationController
  def index
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
    @taken_spots = [["0","0"], ["1","1"], ["2","2"], ["3","3"]]
  end

  def new
    @bed = Bed.new
  end

  def create
    status, @bed = Bed.create(params[:bed])
    if status == 201
      flash[:success] = "YOU WIN!"
      redirect_to beds_path
    else
      @bed = Bed.new
      flash[:error] = "LAME."
      redirect_to beds_path
    end
  end

  private

  def valid_bed
    JSON.parse("{\"id\":1,\"name\":\"Tomatoes\",\"garden_id\":1,\"width\":6,\"depth\":6,\"created_at\":\"2014-01-30T18:06:29.733Z\",\"updated_at\":\"2014-02-03T23:59:36.844Z\",\"notes\":\"Plant cover crop after harvest.\"}")
  end

end
