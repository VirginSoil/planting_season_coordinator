require 'spec_helper'

describe "Bed Information Panel"  do
  VCR.use_cassette('garden-panel') do
    it "sees the bed information panel" do
      page.driver.browser.set_cookie 'user_id=1'
      visit root_path
      within '.bed-information' do
        expect(page).to have_content("Simon's")
      end
    end
  end

  VCR.use_cassette('bed-details') do
    it "sees the bed's name, notes, dimensions, and zipcode" do
      page.driver.browser.set_cookie 'user_id=1'
      visit root_path
      within '.bed-information' do
        expect(page).to have_content("Simon's")
        expect(page).to have_content("I like beer!!! 123")
        expect(page).to have_content("Dimensions")
        expect(page).to have_content("Width: 10")
        expect(page).to have_content("Depth: 10")
        expect(page).to have_content("12345")
      end
    end
  end

  VCR.use_cassette('new-planting') do
    it "sees the plant selects and the submit button", :js => true do
      page.driver.set_cookie("user_id", 1)
      visit root_path
      save_and_open_page
      within '#bed-functions' do
        expect(page).to
        select "Lettuce", from: "planting[plants]"
        click_on "Add to Garden"
      end
    end
  end
end