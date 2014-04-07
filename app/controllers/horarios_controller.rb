class HorariosController < DestinosController
  def index
    linha_ponto_linha_ponto = LinhaPontoLinhaPonto.joins('INNER JOIN linhas_pontos origem ON origem.id = linhas_pontos_linhas_pontos.origem_id')
    .joins('INNER JOIN linhas_pontos destino ON destino.id = linhas_pontos_linhas_pontos.destino_id')
    .where(:origem => { :linha_id => params['linha_id'], :dia_id => params['dia_id'], :ponto_id => params['ponto_id'] })
    .where(:destino => { :ponto_id => params['destino_id']}).first

    Acesso.create!(:ip => request.remote_ip, :linha_ponto_linha_ponto => linha_ponto_linha_ponto)

    @horarios = linha_ponto_linha_ponto.horarios
    @horarios = @horarios.each_slice( (@horarios.size/2.0).round ).to_a

    render :index, :layout => false
  end
end
