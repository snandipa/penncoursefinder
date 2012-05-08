require 'test_helper'

class CreateQuerytimingTest < ActionDispatch::IntegrationTest
   test "Should display proper field metrics" do
      visit new_querytiming_path
      select("Tuesday", :from => "I want my class's section be on:")
      click_button "Find your sections!"
      
      visit querytiming_path(Querytiming.last)
      assert page.has_content?("Tuesday")
   end

end
