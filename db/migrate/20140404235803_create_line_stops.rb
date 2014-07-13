class CreateLineStops < ActiveRecord::Migration
  def change
    create_table :line_stops do |t|
      t.references :line, index: true
      t.references :stop, index: true
      t.references :day, index: true

      t.timestamps
    end
  end
end
