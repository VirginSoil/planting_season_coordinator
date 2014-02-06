class BedsController < ApplicationController
  def index
    @bed = valid_bed
    @width = @bed["width"]
    @depth = @bed["depth"]
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
