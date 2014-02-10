class WelcomeController < ApplicationController
  def index
    response = Faraday.get(client+'api/v1/beds/1')
    # @bed = JSON.parse(response.body)
    @bed = valid_bed
    @width = @bed["width"]
    @depth = @bed["depth"]
  end

  def create

  end

  def new

  end

  private

  def planting_params
    params.require(:planting).permit(:row, :column, :plants)
  end


  def client
    "http://localhost:8080/"
  end

  def valid_bed
    JSON.parse("{\"id\":1,\"name\":\"Tomatoes\",\"garden_id\":1,\"width\":3,\"depth\":2,\"created_at\":\"2014-01-30T18:06:29.733Z\",\"updated_at\":\"2014-02-03T23:59:36.844Z\",\"notes\":\"Plant cover crop after harvest.\"}")
  end
end
