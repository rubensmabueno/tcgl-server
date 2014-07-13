class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :name
      t.integer :to
      t.integer :order
      t.decimal :lat
      t.decimal :lng
      t.decimal :distance

      t.references :line, index: true
      t.references :address, index: true
      t.references :stop, index: true

      t.timestamps
    end
  end
end
