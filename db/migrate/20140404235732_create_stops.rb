class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
