class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.decimal :course_rating_lb
      t.decimal :difficulty_rating_ub
      t.string :requirement_category

      t.timestamps
    end
  end
end
