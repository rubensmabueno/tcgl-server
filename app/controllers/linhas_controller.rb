class LinhasController < ApplicationController
  def posicoes
    linha = Linha.find(params[:id])
    posicoes = []

    posicoes_a = JSON.parse( RestClient.post 'http://site.tcgrandelondrina.com.br:8082/soap/buscamapa', :idLinha => linha.codigo ).values.first.split('&').each_slice(6).to_a

    posicoes_a.each do |posicao|
      unless posicao.size < 4
        posicoes << Posicao.create!(:de => posicao[1], :para => posicao[2], :lat => posicao[3].to_f, :lon => posicao[4].to_f)
      end
    end

    render :js => posicoes.to_json
  end
end
