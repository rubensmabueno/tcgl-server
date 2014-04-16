class CreateAcessosLinhasPontos < ActiveRecord::Migration
  def change
    create_table :acessos_linhas_pontos do |t|
      t.references :linha, index: true
      t.references :dia, index: true
      t.references :origem, index: true
      t.references :destino, index: true
      t.references :acesso, index: true

      t.timestamps
    end
  end
end
