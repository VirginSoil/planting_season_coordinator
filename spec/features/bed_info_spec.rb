require 'spec_helper'

describe "Bed Information Panel" do
  it "sees the garden information panel" do
    visit root_path
    expect(page).to have_content("Tomato Bed Info")
  end
end