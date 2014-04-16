class HorariosController < ApplicationController
  def index
    acesso = Acesso.new(permitted_params)
    acesso.save!

    @horarios = acesso.acessos_linhas_pontos.map { |e| e.horarios }.flatten.sort_by(&:partida)
    #raise @horarios.inspect
    @horarios = @horarios.each_slice( (@horarios.size/2.0).round ).to_a

    render :index, :layout => false
  end

  private
  def permitted_params
    params.require(:acesso).permit(:acessos_linhas_pontos_attributes => [ :linha_id, :dia_id, :origem_id, :destino_id ])
  end
end
