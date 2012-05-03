class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.decimal :start_time
      t.decimal :end_time
      t.integer :day
      t.integer :section_id
      t.integer :recitation_id

      t.timestamps
    end
  end
end
