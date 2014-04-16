class CreateEnderecos < ActiveRecord::Migration
  def change
    create_table :enderecos do |t|
      t.string :rua
      t.string :numero
      t.string :cep

      t.references :bairro
      t.references :cidade
      t.references :estado

      t.timestamps
    end
  end
end
