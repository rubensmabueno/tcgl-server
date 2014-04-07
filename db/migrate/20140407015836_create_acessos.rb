class CreateAcessos < ActiveRecord::Migration
  def change
    create_table :acessos do |t|
      t.string :ip
      t.references :linha_ponto_linha_ponto, index: true

      t.timestamps
    end
  end
end
