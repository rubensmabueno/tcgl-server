class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :from
      t.string :to
      t.integer :bus
      t.decimal :lat
      t.decimal :lng

      t.references :line, index: true

      t.timestamps
    end
  end
end
