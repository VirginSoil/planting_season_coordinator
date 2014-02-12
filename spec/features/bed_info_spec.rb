require 'spec_helper'

describe "Bed Information Panel", :js => true do
  it "sees the garden information panel" do
    visit root_path
    within '#bed-info-panel' do
      expect(page).to have_content("Tomatoes Info")
    end
  end

  it "sees the bed's name and notes" do
    visit root_path
    within '#bed-info-panel' do
      expect(page).to have_content("Tomatoes")
      expect(page).to have_content("Notes: Plant cover crop after harvest.")
    end
  end

  xit "sees the row, column, and plant selects and the submit button" do
    visit root_path
    within '#bed-view-panel' do
      select "A", from: "planting[row]"
      select "1", from: "planting[column]"
      select "Lettuce", from: "planting[plants]"
      click_on "Add to Garden"
    end
  end
end
