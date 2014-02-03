class WelcomeController < ApplicationController
  def index

    @bed = JSON.parse("{\"id\":1,\"name\":\"Tomatoes\",\"garden_id\":1,\"width\":3,\"depth\":2,\"created_at\":\"2014-01-30T18:06:29.733Z\",\"updated_at\":\"2014-02-03T22:53:32.695Z\",\"notes\":\"Plant cover crop after harvest.\"}")
    @width = @bed["width"]
    @depth = @bed["depth"]
  end
end
