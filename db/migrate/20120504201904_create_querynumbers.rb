class CreateQuerynumbers < ActiveRecord::Migration
  def change
    create_table :querynumbers do |t|
      t.integer :course_number_lower_bound
      t.integer :course_number_upper_bound
      t.string :department

      t.timestamps
    end
  end
end
