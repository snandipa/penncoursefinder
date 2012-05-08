require 'test_helper'

class CreateQuerynumberTest < ActionDispatch::IntegrationTest
   test "Should display errors on page if incomplete fields" do
      visit new_querynumber_path
      fill_in "I want my course to have this department:", with:"CIS"
      fill_in "I want my course to be above:", with:100
      click_button "Find your courses!"
      
      error_message = "Course number upper bound can't be blank"
      assert page.has_content?(error_message)
   end
   
    test "Should display proper courses with the right fields" do
      visit new_querynumber_path
      fill_in "I want my course to have this department:", with:"CIS"
      fill_in "I want my course to be above:", with:100
      fill_in "I want my course to be below:", with:200
      click_button "Find your courses!"
      
      visit querynumber_path(Querynumber.last)
      assert page.has_content?("CIS")
   end
end
