class HomeController < ApplicationController
  def index
    @acesso = Access.new
  end

  def horario
    linhas_pontos_linhas_pontos = LineStopLineStop
    .joins('INNER JOIN linhas_pontos origem ON origem.id = linhas_pontos_linhas_pontos.origem_id')
    .joins('INNER JOIN linhas_pontos destino ON destino.id = linhas_pontos_linhas_pontos.destino_id')
    .where('origem.ponto_id = '+params['origem_id']+' AND origem.linha_id = '+params['linha_id']+' AND origem.dia_id = '+params['dia_id'])
    .where('destino.ponto_id = '+params['destino_id']).first

    @schedules = linhas_pontos_linhas_pontos.schedules.order(:departure) unless linhas_pontos_linhas_pontos.nil?

    render 'horario', :layout => false
  end
end
