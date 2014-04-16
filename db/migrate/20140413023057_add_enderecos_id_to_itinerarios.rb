class AddEnderecosIdToItinerarios < ActiveRecord::Migration
  def change
    change_table :itinerarios do |t|
      t.column :endereco_id, :integer
      t.column :ponto_id, :integer
      t.column :distancia, :decimal
    end
  end
end
