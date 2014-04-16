class AddLinhaIdToPosicoes < ActiveRecord::Migration
  def change
    change_table :posicoes do |t|
      t.column :linha_id, :integer
    end
  end
end
