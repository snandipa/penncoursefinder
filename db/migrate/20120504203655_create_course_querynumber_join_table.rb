class CreateCourseQuerynumberJoinTable < ActiveRecord::Migration
  def change
    create_table :courses_querynumbers, :id => false do |t|
      t.integer :course_id
      t.integer :querynumber_id
    end
  end
end
