class CreatePontos < ActiveRecord::Migration
  def change
    create_table :pontos do |t|
      t.string :codigo
      t.string :nome

      t.timestamps
    end
  end
end
