class CreateQuerytimingSectionJoinTable < ActiveRecord::Migration
  def change
    create_table :querytimings_sections, :id => false do |t|
      t.integer :querytiming_id
      t.integer :section_id
    end
  end
end
