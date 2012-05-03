class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :listing
      t.integer :course_id
      t.decimal :instructor_rating
      t.string :instructor

      t.timestamps
    end
  end
end
