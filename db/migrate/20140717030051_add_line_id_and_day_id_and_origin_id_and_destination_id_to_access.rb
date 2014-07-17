class AddLineIdAndDayIdAndOriginIdAndDestinationIdToAccess < ActiveRecord::Migration
  def change
    change_table :accesses do |t|
      t.column :line_id, :integer
      t.column :day_id, :integer
      t.column :origin_id, :integer
      t.column :destination_id, :integer

      t.remove :line_stop_line_stop_id
    end
  end
end
