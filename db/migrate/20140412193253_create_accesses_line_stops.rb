class CreateAccessesLineStops < ActiveRecord::Migration
  def change
    create_table :accesses_line_stops do |t|
      t.references :line, index: true
      t.references :day, index: true
      t.references :origin, index: true
      t.references :destination, index: true
      t.references :access, index: true

      t.timestamps
    end
  end
end
