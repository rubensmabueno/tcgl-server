class AcessoLinhaPonto < ActiveRecord::Base
  belongs_to :linha
  belongs_to :dia
  belongs_to :origem
  belongs_to :destino

  belongs_to :acesso

  def horarios
    LinhaPontoLinhaPonto.joins('INNER JOIN linhas_pontos origem ON origem.id = linhas_pontos_linhas_pontos.origem_id')
    .joins('INNER JOIN linhas_pontos destino ON destino.id = linhas_pontos_linhas_pontos.destino_id')
    .where(:origem => { :linha_id => self.linha_id, :dia_id => self.dia_id, :ponto_id => self.origem_id })
    .where(:destino => { :ponto_id => self.destino_id}).first.horarios
  end
end
