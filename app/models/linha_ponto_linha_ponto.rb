class LinhaPontoLinhaPonto < ActiveRecord::Base
  belongs_to :origem, :class_name => 'LinhaPonto'
  belongs_to :destino, :class_name => 'LinhaPonto'

  has_many :horarios
end
