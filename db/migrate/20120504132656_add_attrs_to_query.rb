class AddAttrsToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :course_rating_lower_bound, :decimal
    add_column :queries, :difficulty_rating_upper_bound, :decimal

  end
end
