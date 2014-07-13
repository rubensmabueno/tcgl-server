class CreateNeighbouhoods < ActiveRecord::Migration
  def change
    create_table :neighbourhoods do |t|
      t.string :name

      t.timestamps
    end
  end
end
