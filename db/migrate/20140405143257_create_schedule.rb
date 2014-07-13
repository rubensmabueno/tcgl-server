class CreateSchedule < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.time :departure
      t.time :arrive

      t.references :line_stop_line_stop, index: true
      t.string :via

      t.timestamps
    end
  end
end
