class CreateLinhasPontosLinhasPontos < ActiveRecord::Migration
  def change
    create_table :linhas_pontos_linhas_pontos do |t|
      t.references :origem, index: true
      t.references :destino, index: true

      t.timestamps
    end
  end
end
