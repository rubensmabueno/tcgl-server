class CreateTypeLines < ActiveRecord::Migration
  def change
    create_table :type_lines do |t|
      t.string :name

      t.timestamps
    end
  end
end
