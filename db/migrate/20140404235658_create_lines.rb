class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :code
      t.string :name
      t.references :type_line, index: true

      t.timestamps
    end
  end
end
