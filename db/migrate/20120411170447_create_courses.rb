class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :department
      t.integer :number
      t.string :name
      t.decimal :course_rating
      t.decimal :difficulty_rating
      t.integer :cusip
      t.decimal :cus

      t.timestamps
    end
  end
end
