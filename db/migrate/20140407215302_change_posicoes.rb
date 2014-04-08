class ChangePosicoes < ActiveRecord::Migration
  def up
    change_table :posicoes do |t|
      t.column :onibus, :integer
    end

    rename_column :posicoes, :lon, :lng
  end

  def down
    change_table :posicoes do |t|
      t.remove :onibus
    end

    rename_column :posicoes, :lng, :lon
  end
end
