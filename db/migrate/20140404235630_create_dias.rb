class CreateDias < ActiveRecord::Migration
  def change
    create_table :dias do |t|
      t.string :nome

      t.timestamps
    end
  end
end
