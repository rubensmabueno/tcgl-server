class LinhasController < ApplicationController
  def posicoes
    linha = Linha.find(params[:id])
    posicoes = []

    posicoes_a = JSON.parse( RestClient.post 'http://site.tcgrandelondrina.com.br:8082/soap/buscamapa', :idLinha => linha.codigo ).values.first.split('&').each_slice(6).to_a

    posicoes_a.each_with_index do |posicao, index|
      unless posicao.size < 4
        ultima_posicao = Posicao.where(:de => posicao[1].split("-->").last, :para => posicao[2].split("Indo para: ").last, :lat => posicao[3].to_f, :lng => posicao[4].to_f, :onibus => index).last

        if ultima_posicao.blank?
        posicoes << Posicao.create!(:de => posicao[1].split("-->").last, :para => posicao[2].split("Indo para: ").last, :lat => posicao[3].to_f, :lng => posicao[4].to_f, :onibus => index)
        else
          posicoes << ultima_posicao
        end
      end
    end

    render :js => posicoes.to_json
  end
end
