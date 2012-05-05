class CreateQuerytimings < ActiveRecord::Migration
  def change
    create_table :querytimings do |t|
      t.decimal :desired_start_time
      t.decimal :desired_end_time
      t.integer :desired_day

      t.timestamps
    end
  end
end
