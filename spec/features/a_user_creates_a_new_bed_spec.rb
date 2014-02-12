require 'spec_helper'

feature "Bed-info" do 

  scenario "on new bed page" do 
    visit "bed_show_path"
    within ".bed-info" do 
      fill_in "Bed Name", with: "Billy BBQ Tomato Sauce"
      fill_in "Zipcode", with: "80210"
      fill_in "Notes", with: "Billy's Tomato Garden"
      fill_in "Width", with: 5
      fill_in "Depth", with: 5
      click_on "Create Your Garden Now"
   end
   expect(page).to have_content("YOU WIN!")
  end
end
