class CreateCourseQueryJoinTable < ActiveRecord::Migration
  def change
    create_table :courses_queries, :id => false do |t|
      t.integer :course_id
      t.integer :query_id
    end
  end
end
