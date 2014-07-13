class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.string :ip
      t.references :line_stop_line_stop, index: true

      t.timestamps
    end
  end
end
