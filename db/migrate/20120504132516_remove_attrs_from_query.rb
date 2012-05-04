class RemoveAttrsFromQuery < ActiveRecord::Migration
  def up
    remove_column :queries, :course_rating_lb
    remove_column :queries, :difficulty_rating_ub
  end

  def down
    add_column :queries, :difficulty_rating_ub, :decimal
    add_column :queries, :course_rating_lb, :decimal
  end
end
