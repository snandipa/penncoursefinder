require 'test_helper'

class RecitationTest < ActiveSupport::TestCase
 test "should be able to add a single meeting to a recitation" do
 c= Course.create(:department => "ACCT", :number => 101, :name => "PRINCIPLES OF ACCOUNTING", :cusip => 32498, :cus => 1.0, :course_rating => 2.465, :difficulty_rating => 3.0049999999999994)

r1 = Recitation.create(listing:212, course_id:Course.find_by_cusip(32498))
t1 = Meeting.create(start_time:11.0, end_time:12.0, day:5)
assert r1.meetings.count == 0, "Allowed you to improperly associate a meeting with a recitation"
end

end
