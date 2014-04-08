class CreateTiposLinhas < ActiveRecord::Migration
  def change
    create_table :tipos_linhas do |t|
      t.string :nome

      t.timestamps
    end
  end
end
