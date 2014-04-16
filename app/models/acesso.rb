class Acesso < ActiveRecord::Base
  has_many :acessos_linhas_pontos

  accepts_nested_attributes_for :acessos_linhas_pontos

  after_initialize :build_acessos_linhas_pontos

  def build_acessos_linhas_pontos
    self.acessos_linhas_pontos.build unless self.acessos_linhas_pontos.any?
  end
end
