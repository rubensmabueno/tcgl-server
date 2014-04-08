class CreateLinhas < ActiveRecord::Migration
  def change
    create_table :linhas do |t|
      t.string :codigo
      t.string :nome
      t.references :tipo_linha, index: true

      t.timestamps
    end
  end
end
