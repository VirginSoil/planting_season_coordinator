require 'spec_helper'

def valid_bed
  "{\"id\":1,\"name\":\"Tomatoes\",\"garden_id\":1,\"width\":10,\"depth\":10,\"created_at\":\"2014-01-30T18:06:29.733Z\",\"updated_at\":\"2014-02-03T22:53:32.695Z\",\"notes\":\"Plant cover crop after harvest.\"}"
end

describe "Bed Information Panel" do
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

  it "sees the row, column, and plant selects and the submit button" do
    visit root_path
    within '#bed-view-panel' do
      select "A", from: "planting[row]"
      select "1", from: "planting[column]"
      select "Lettuce", from: "planting[plants]"
      click_on "Add to Garden"
    end
  end
end