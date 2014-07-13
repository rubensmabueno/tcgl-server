class CreateLineStopsLineStops < ActiveRecord::Migration
  def change
    create_table :line_stops_line_stops do |t|
      t.references :origin, index: true
      t.references :destination, index: true

      t.timestamps
    end
  end
end
