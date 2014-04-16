class LinhasController < ApplicationController
  def posicoes
    linhas = Linha.where(:id => params['linhas_id'])
    posicoes = []

    linhas.each do |linha|
      posicoes_b = JSON.parse( RestClient.post 'http://site.tcgrandelondrina.com.br:8082/soap/buscamapa', :idLinha => linha.codigo ).values.first.split('&').each_slice(6).to_a

      posicoes_b.each_with_index do |posicao, index|
        unless posicao.size < 4
          ultima_posicao = Posicao.where(:de => posicao[1].split("-->").last, :para => posicao[2].split("Indo para: ").last, :lat => posicao[3].to_f, :lng => posicao[4].to_f, :onibus => index, :linha => linha).last

          if ultima_posicao.blank?
            posicoes << Posicao.create!(:de => posicao[1].split("-->").last, :para => posicao[2].split("Indo para: ").last, :lat => posicao[3].to_f, :lng => posicao[4].to_f, :onibus => index, :linha => linha)
          else
            posicoes << ultima_posicao
          end
        end
      end
    end

    render :js => posicoes.to_json(:methods => [ :linha ])
  end

  def itinerarios
    itinerarios = {}

    linhas = Linha.where(:id => params['linhas_id']).order(:ordem)
    Itinerario.where(:linha_id => params['linhas_id'] ).order(:ordem).group_by(&:linha_id).each { |index, e| itinerarios[index] = e.group_by(&:sentido) }
    render :js => itinerarios.to_json(:methods => [ :color ])
  end

  def partidas
    itinerarios = Itinerario.within(0.1, :units => :kms, :origin => params['posicao_partida'].values)
    radius = 0.1

    unless itinerarios.any?
      itinerarios = Itinerario.in_range(0.1..0.3, :units => :kms, :origin => params['posicao_partida'].values)
      radius = 0.3

      unless itinerarios.any?
        itinerarios = Itinerario.by_distance(:units => :kms, :origin => params['posicao_partida'].values).limit(3)
        radius = itinerarios.uniq_by(&:linha_id).sort_by { |e| e.distance_to(params['posicao_partida'].values) }.last.distance_to(params['posicao_partida'].values)
      end
    end

    render :js => { :itinerario => itinerarios.uniq_by(&:linha_id).map { |e| e.linha }, :distancia => radius }.to_json(:methods => [:codigo_nome])
  end

  def chegadas
    itinerarios = Itinerario.within(0.1, :units => :kms, :origin => params['posicao_chegada'].values)
    radius = 0.1

    unless itinerarios.any?
      itinerarios = Itinerario.in_range(0.1..0.3, :units => :kms, :origin => params['posicao_chegada'].values)
      radius = 0.3

      unless itinerarios.any?
        itinerarios = Itinerario.by_distance(:units => :kms, :origin => params['posicao_chegada'].values).limit(3)
        radius = itinerarios.uniq_by(&:linha_id).sort_by { |e| e.distance_to(params['posicao_chegada'].values) }.last.distance_to(params['posicao_chegada'].values)
      end
    end

    render :js => { :itinerario => itinerarios.uniq_by(&:linha_id).map { |e| e.linha }, :distancia => radius }.to_json(:methods => [:codigo_nome])
  end
end
