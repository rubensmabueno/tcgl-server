class LinhaPonto < ActiveRecord::Base
  belongs_to :linha
  belongs_to :ponto
  belongs_to :dia

  has_many :linhas_pontos_linhas_pontos, :foreign_key => :origem_id
  has_many :destinos, :through => :linhas_pontos_linhas_pontos, :class_name => 'LinhaPonto', :foreign_key => :destino_id
end
