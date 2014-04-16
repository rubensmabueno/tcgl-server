class ChangeAcessos < ActiveRecord::Migration
  def change
    remove_column :acessos, :linha_ponto_linha_ponto_id
  end
end
