require 'spec_helper'

feature "Bed-info" do 

  # before :each do
  #   page.driver.browser.set_cookie 'user_id=1'
  # end


  scenario "on new bed page" do 
    visit "/beds/new"
    within ".bed-info" do 
      fill_in "Bed Name", with: "Billy BBQ Tomato Sauce"
      fill_in "Zipcode", with: "80210"
      fill_in "Notes", with: "Billy's Tomato Garden"
      fill_in "Width", with: 5
      fill_in "Depth", with: 5
      click_on "Create Your Garden Now"
   end
  end
end
