class DestinosController < PontosController
  def index
    linha_ponto = LinhaPonto.where(:linha_id => params['linha_id'], :dia_id => params['dia_id'], :ponto_id => params['ponto_id']).all

    render :js => linha_ponto.to_json(:include => { :ponto => {}, :destinos => { :include => { :ponto => {}}} })
  end
end
