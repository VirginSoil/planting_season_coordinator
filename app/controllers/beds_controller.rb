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
  end

  def create
    status, @bed = Bed.create(params[:bed])
    if status == 201
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
    JSON.parse("{\"id\":1,\"name\":\"Tomatoes\",\"garden_id\":1,\"width\":12,\"depth\":12,\"created_at\":\"2014-01-30T18:06:29.733Z\",\"updated_at\":\"2014-02-03T23:59:36.844Z\",\"notes\":\"Plant cover crop after harvest.\"}")
  end

  def all_the_plants
    JSON.parse("[{\"id\":1,\"name\":\"Beets\",\"days_to_harvest\":\"60\",\"age_of_transplant\":\" \",\"warm_season\":false,\"created_at\":\"2014-01-30T22:39:39.408Z\",\"updated_at\":\"2014-01-30T23:00:51.393Z\",\"spacing\":\"4-6”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"7-10\",\"depth\":\"3/4-1\"},{\"id\":3,\"name\":\"Broccoli\",\"days_to_harvest\":\"65T\",\"age_of_transplant\":\"5-7\",\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.306Z\",\"updated_at\":\"2014-01-30T23:00:51.187Z\",\"spacing\":\"18”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"3-10\",\"depth\":\"1/2\"},{\"id\":4,\"name\":\"Cabbage\",\"days_to_harvest\":\"85T\",\"age_of_transplant\":\"5-7\",\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.309Z\",\"updated_at\":\"2014-01-30T23:11:44.664Z\",\"spacing\":\"18”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"3-10\",\"depth\":\"1/2\"},{\"id\":5,\"name\":\"Carrots\",\"days_to_harvest\":\"70\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.316Z\",\"updated_at\":\"2014-01-30T23:12:06.482Z\",\"spacing\":\"2-3”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"10-17\",\"depth\":\"1\"},{\"id\":6,\"name\":\"Cauliflower\",\"days_to_harvest\":\"65T\",\"age_of_transplant\":\"5-7\",\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.319Z\",\"updated_at\":\"2014-01-30T23:00:51.297Z\",\"spacing\":\"18”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"3-10\",\"depth\":\"1/2\"},{\"id\":7,\"name\":\"Kohlrabi\",\"days_to_harvest\":\"50\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.322Z\",\"updated_at\":\"2014-01-30T23:12:17.370Z\",\"spacing\":\"7-9”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"3-10\",\"depth\":\"1/2\"},{\"id\":8,\"name\":\"Leeks\",\"days_to_harvest\":\"120\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.325Z\",\"updated_at\":\"2014-01-30T23:00:51.304Z\",\"spacing\":\"4-6”\",\"germination_temperature\":\"80° \",\"days_to_germination\":\"7-12\",\"depth\":\"1/4\"},{\"id\":9,\"name\":\"Lettuce (Leaf)\",\"days_to_harvest\":\"60\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.337Z\",\"updated_at\":\"2014-01-30T23:12:27.720Z\",\"spacing\":\"7-9\",\"germination_temperature\":\"70\",\"days_to_germination\":\"4-10\",\"depth\":\"1/4\"},{\"id\":11,\"name\":\"Onions, Green\",\"days_to_harvest\":\"60\",\"age_of_transplant\":\"7-12\",\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.347Z\",\"updated_at\":\"2014-01-30T23:14:33.721Z\",\"spacing\":\"2-3\",\"germination_temperature\":\"80\",\"days_to_germination\":\"7-12\",\"depth\":\"1\"},{\"id\":12,\"name\":\"Onions, Dry(seed)\",\"days_to_harvest\":\"110\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.351Z\",\"updated_at\":\"2014-01-30T23:16:14.651Z\",\"spacing\":\"4-6\",\"germination_temperature\":\"80\",\"days_to_germination\":\"7-12\",\"depth\":\"1\"},{\"id\":13,\"name\":\"Parsnips\",\"days_to_harvest\":\"70\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.354Z\",\"updated_at\":\"2014-01-30T23:17:06.826Z\",\"spacing\":\"5-6”\",\"germination_temperature\":\"70°\",\"days_to_germination\":\"15-25\",\"depth\":\"1\"},{\"id\":14,\"name\":\"Peas\",\"days_to_harvest\":\"8”\",\"age_of_transplant\":\"1”\",\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.357Z\",\"updated_at\":\"2014-01-30T23:17:55.054Z\",\"spacing\":\"4-6 or 3-8\",\"germination_temperature\":\"70°\",\"days_to_germination\":\"6-15\",\"depth\":\"1\"},{\"id\":15,\"name\":\"Potatoes\",\"days_to_harvest\":\"125\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.359Z\",\"updated_at\":\"2014-01-30T23:00:51.334Z\",\"spacing\":\"12-15\",\"germination_temperature\":null,\"days_to_germination\":\"45\",\"depth\":\"4-6\"},{\"id\":16,\"name\":\"Radish\",\"days_to_harvest\":\"30\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.361Z\",\"updated_at\":\"2014-01-30T23:00:51.339Z\",\"spacing\":\"2-3”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"3-10\",\"depth\":\"1/2\"},{\"id\":17,\"name\":\"Spinach\",\"days_to_harvest\":\"40\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.364Z\",\"updated_at\":\"2014-01-30T23:00:51.343Z\",\"spacing\":\"4-6”\",\"germination_temperature\":\"70°\",\"days_to_germination\":\"6-14\",\"depth\":\"1/2\"},{\"id\":18,\"name\":\"Swiss Chard\",\"days_to_harvest\":\"60\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.366Z\",\"updated_at\":\"2014-01-30T23:00:51.346Z\",\"spacing\":\"7-9\",\"germination_temperature\":\"85°\",\"days_to_germination\":\"17\",\"depth\":\"1”\"},{\"id\":19,\"name\":\"Turnips\",\"days_to_harvest\":\"50\",\"age_of_transplant\":null,\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.368Z\",\"updated_at\":\"2014-01-30T23:00:51.350Z\",\"spacing\":\"4-6”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"3-10\",\"depth\":\"1/2\"},{\"id\":21,\"name\":\"Beans\",\"days_to_harvest\":\"60\",\"age_of_transplant\":null,\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.375Z\",\"updated_at\":\"2014-01-30T23:03:10.060Z\",\"spacing\":\"6”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"6-14\",\"depth\":\"1-1 1/2\"},{\"id\":22,\"name\":\"Cantaloupe\",\"days_to_harvest\":\"85\",\"age_of_transplant\":\"2-3\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.378Z\",\"updated_at\":\"2014-01-30T23:03:10.072Z\",\"spacing\":\"36-48”\",\"germination_temperature\":\"90°\",\"days_to_germination\":\"3-12\",\"depth\":\"1- 1 1/2\"},{\"id\":23,\"name\":\"Corn\",\"days_to_harvest\":\"60-90\",\"age_of_transplant\":null,\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.387Z\",\"updated_at\":\"2014-01-30T23:03:10.078Z\",\"spacing\":\"12x30\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"5-10\",\"depth\":\"1-1 1/2\"},{\"id\":24,\"name\":\"Cucumbers, untrellised\",\"days_to_harvest\":\"55\",\"age_of_transplant\":\"2-3\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.389Z\",\"updated_at\":\"2014-01-30T23:03:10.081Z\",\"spacing\":\"6” trellissed, 24-36” untrellised\",\"germination_temperature\":\"90°\",\"days_to_germination\":\"6-10\",\"depth\":\"1\"},{\"id\":25,\"name\":\"Eggplant\",\"days_to_harvest\":\"60T\",\"age_of_transplant\":\"6-9\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.391Z\",\"updated_at\":\"2014-01-30T23:03:10.085Z\",\"spacing\":\"18-24”\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"7-14\",\"depth\":\"1/4\"},{\"id\":26,\"name\":\"Pepper\",\"days_to_harvest\":\"70T\",\"age_of_transplant\":\"6-8\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.394Z\",\"updated_at\":\"2014-01-30T23:03:10.088Z\",\"spacing\":\"15-18” \",\"germination_temperature\":\"80°\",\"days_to_germination\":\"10-20\",\"depth\":\"1/4\"},{\"id\":27,\"name\":\"Tomato\",\"days_to_harvest\":\"65\",\"age_of_transplant\":\"5-7\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.398Z\",\"updated_at\":\"2014-01-30T23:03:10.094Z\",\"spacing\":\"24 trellissed\",\"germination_temperature\":\"80°\",\"days_to_germination\":\"6-14\",\"depth\":\"1/4\"},{\"id\":28,\"name\":\"Squash, Summer\",\"days_to_harvest\":\"50\",\"age_of_transplant\":\"2-3\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.402Z\",\"updated_at\":\"2014-01-30T23:00:51.382Z\",\"spacing\":\"36-48\",\"germination_temperature\":\"95°\",\"days_to_germination\":\"3-12\",\"depth\":\"1-1 1/2\"},{\"id\":29,\"name\":\"Squash, Winter\",\"days_to_harvest\":\"100\",\"age_of_transplant\":\"6-10\",\"warm_season\":false,\"created_at\":\"2014-01-30T22:40:03.405Z\",\"updated_at\":\"2014-01-30T23:00:51.386Z\",\"spacing\":\"36-48\",\"germination_temperature\":\"95°\",\"days_to_germination\":\"3-12\",\"depth\":\"1-1 1/2\"},{\"id\":30,\"name\":\"Watermelons\",\"days_to_harvest\":\"85\",\"age_of_transplant\":\"2-3\",\"warm_season\":true,\"created_at\":\"2014-01-30T22:40:03.407Z\",\"updated_at\":\"2014-01-30T23:00:51.389Z\",\"spacing\":\"36-48”\",\"germination_temperature\":\"90°\",\"days_to_germination\":\"3-12\",\"depth\":\"1-1 1/2\"}]")
  end

  def all_plant_names
    all_the_plants.map {|plant| plant["name"] }
  end

end
