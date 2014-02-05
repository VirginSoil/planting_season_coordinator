require 'spec_helper'

feature "Bed-info" do 

  # before :each do
  #   page.driver.browser.set_cookie 'user_id=1'
  # end


  scenario "on new bed page" do 
    visit "/beds/new"
    within ".bed-info" do 
      fill_in "name", with: "Billy BBQ Tomato Sauce"
      fill_in "notification", with: "3333333333"
      fill_in "zipcode", with: "80210"
      fill_in "notes", with: "Billy's Tomato Garden"
      click_on "Create New Bed"
   end
  end
end
