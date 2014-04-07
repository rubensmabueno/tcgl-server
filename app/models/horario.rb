class Horario < ActiveRecord::Base
  belongs_to :linha_ponto_linha_ponto

  default_scope order(:partida)

  def chegada_s
    self[:chegada].strftime("%H:%M:%S")
  end

  def partida_s
    self[:partida].strftime("%H:%M:%S")
  end
end
