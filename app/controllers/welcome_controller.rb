class WelcomeController < ApplicationController
  def index
    response = Faraday.get('http://localhost:8080/api/v1/beds/1')
    @bed = JSON.parse(response.body)
    @width = @bed["width"]
    @depth = @bed["depth"]
  end

  def create
    # query = { :row => params[:planting][:row],
    #           :column => params[:planting][:column],
    #           :plant_id => 1, #params[:planting][:plants],
    #           :bed_id => 1}
    # response = Faraday.post('http://localhost:9293/api/v1/plantings')
    # @bed = JSON.parse(response.body)
    # render :index
  end

  private

  def planting_params
    params.require(:planting).permit(:row, :column, :plants)
  end
end
