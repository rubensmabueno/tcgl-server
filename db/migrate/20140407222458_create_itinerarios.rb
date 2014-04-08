class CreateItinerarios < ActiveRecord::Migration
  def change
    create_table :itinerarios do |t|
      t.string :nome
      t.integer :sentido
      t.decimal :lat
      t.decimal :lng
      t.references :linha, index: true

      t.timestamps
    end
  end
end
