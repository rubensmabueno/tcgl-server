class CreateLinhasPontos < ActiveRecord::Migration
  def change
    create_table :linhas_pontos do |t|
      t.references :linha, index: true
      t.references :ponto, index: true
      t.references :dia, index: true

      t.timestamps
    end
  end
end
