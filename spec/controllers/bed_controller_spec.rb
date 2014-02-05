require 'spec_helper'

describe BedsController do
  let(:params) { { :bed => {     :name    => "HERBS!!",
                                 :notes   => "These are all the herbs!",
                                 :zipcode => "80210",
                                 :width   => 5,
                                 :depth   => 5 } } }

  it "creates a bed" do
    cookies.signed[:user_id] = 1
    VCR.use_cassette "controller_create_a_new_bed" do
      post :create, params
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)["name"]).to eq "Herb Garden Bed"
    end
  end
end
