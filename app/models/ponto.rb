class Ponto < ActiveRecord::Base
  has_many :linhas_pontos
  has_many :linhas, :through => :linhas_pontos
end
