class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.time :partida
      t.time :chegada

      t.references :linha_ponto_linha_ponto, index: true
      t.string :via

      t.timestamps
    end
  end
end
