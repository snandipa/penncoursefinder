require 'test_helper'

class CreateQueryTest < ActionDispatch::IntegrationTest
   test "Should display errors on page if incomplete fields" do
      visit new_query_path
      fill_in "I want my course to be rated higher than:", with:1.0
      click_button "Find your courses!"
      
      error_message = "Difficulty rating upper bound can't be blank"
      assert page.has_content?(error_message)
   end
end
