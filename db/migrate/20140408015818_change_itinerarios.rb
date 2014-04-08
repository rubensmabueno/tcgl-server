class ChangeItinerarios < ActiveRecord::Migration
  def change
    change_table :itinerarios do |t|
      t.column :ordem, :integer
    end
  end
end
