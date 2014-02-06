require 'spec_helper'

describe BedsController do
  xit "creates a bed" do
    cookies.signed[:user_id] = 1
    VCR.use_cassette "controller_create_a_new_bed" do
      post :create, bed: {
                           :name => "Tomato bed",
                          :garden_id => 1,
                          :width => 10,
                          :depth => 10,
                          :notes => "Plant cover crop after harvest."
                    }


      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)["name"]).to eq "Herb Garden Bed"
    end
  end
end
