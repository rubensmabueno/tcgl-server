class Linha < ActiveRecord::Base
  belongs_to :tipo_linha

  has_many :linhas_pontos
  has_many :pontos, :through => :linhas_pontos
  has_many :itinerarios

  def codigo_nome
    codigo + ' - ' + nome
  end
end
