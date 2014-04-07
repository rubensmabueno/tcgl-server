class CreatePosicoes < ActiveRecord::Migration
  def change
    create_table :posicoes do |t|
      t.string :de
      t.string :para
      t.decimal :lat
      t.decimal :lon

      t.timestamps
    end
  end
end
