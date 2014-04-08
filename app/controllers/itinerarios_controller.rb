class ItinerariosController < ApplicationController
  def index
    itinerarios = Itinerario.where(:linha_id => params['linha_id'] ).group_by(&:sentido)
    #raise itinerarios.inspect

    render :js => itinerarios.to_json(:methods => [ :color ])
  end
end
