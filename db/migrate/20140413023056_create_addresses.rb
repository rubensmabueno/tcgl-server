class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :postal_code

      t.references :neighbourhood, index: true
      t.references :city, index: true
      t.references :state, index: true

      t.timestamps
    end
  end
end
