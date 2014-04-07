class DiasController < ApplicationController
  def index
    dias = Dia.joins(:linhas_pontos).where(:linhas_pontos => { :linha_id => params['linha_id'] }).uniq
    render :js => dias.to_json(:methods => :today)
  end
end
