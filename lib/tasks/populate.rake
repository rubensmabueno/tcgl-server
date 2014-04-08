namespace :populate do
  desc "TODO"
  task all: [:linhas_pontos, :dias, :linhas, :pontos, :horarios, :itinerarios]

  desc "TODO"
  task linhas_pontos: :environment do
    TipoLinha.create!(:nome => 'Linhas Convencionais')
    TipoLinha.create!(:nome => 'Linhas PSIU')

    puts "Tipos de Linhas criadas"
  end

  desc "TODO"
  task dias: :environment do
    Dia.create!(:nome => 'SEMANA')
    Dia.create!(:nome => 'SÁBADO')
    Dia.create!(:nome => 'DOMINGO')

    puts "Dias criados"
  end

  desc "TODO"
  task linhas: :environment do
    TipoLinha.all.each do |tipo_linha|
      params = {'buscarlinha' => tipo_linha.nome,
                'rnd' => '0.180445113684982060'}

      begin
        linhas = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/Soap/BuscarLinhas'), params)
        puts linhas if linhas.code != '200'
      end while linhas.code != '200'

      linhas = JSON.parse(linhas.body).first['valor'].map { |e| { :codigo => e.split(' - ').first, :nome => ( e.split(' - ')[1..-1].join(' - ') ), :tipo_linha => tipo_linha } }

      linhas.each do |linha|
        Linha.find_or_create_by_nome(linha);
      end
    end

    puts "Linhas criadas"
  end

  desc "TODO"
  task pontos: :environment do
    Linha.all.each do |linha|
      Dia.all.each do |dia|
        params = {'pLinha' => linha.codigo,
                  'pDia' => dia.id}

        begin
          pontos = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/Soap/BuscarPontos'), params)
          puts pontos if pontos.code != '200'
        end while pontos.code != '200'

        pontos = JSON.parse(pontos.body).first['valor'].map { |e| { :codigo => e.split(' - ').first, :nome => ( e.split(' - ')[1..-1].join(' - ') ) } }

        pontos.each do |ponto|
          ponto = Ponto.find_or_initialize_by_nome(ponto)
          ponto.linhas_pontos.build(:dia => dia, :linha => linha)
          ponto.save!
        end
      end
    end

    puts "Pontos criados"
  end

  desc "TODO"
  task horarios: :environment do
    LinhaPonto.all.group_by(&:linha).each do |linha, linha_ponto_grouped_by_id|
      linha_ponto_grouped_by_id.group_by(&:dia).each do |dia, linha_ponto_grouped_by_id_and_date|
        linha_ponto_grouped_by_id_and_date.each do |linha_ponto_origem|
          ( linha_ponto_grouped_by_id_and_date - [ linha_ponto_origem ] ).each do |linha_ponto_destino|
            horarios = []
            begin
              request = RestClient.post 'http://site.tcgrandelondrina.com.br:8082/soap/BuscaHorarios', :idLinha => linha.codigo, :idDia => dia.id, :idLinhaO => linha_ponto_origem.ponto.codigo, :idLinhaD => linha_ponto_destino.ponto.codigo
              puts request if request.code != 200
            end while request.code != 200

            doc = Nokogiri::HTML(request)

            doc.css('table.tabHoraria tr.trHorariaPar, table.tabHoraria tr.trHorariaImpar').each do |row_horario|
              ( horarios << row_horario.css('td.tdHoraria').map { |e| e.content } ) unless row_horario.css('td.tdHoraria').map { |e| e.content }.blank?
            end

            unless horarios.blank?
              linha_ponto_linha_ponto = LinhaPontoLinhaPonto.new(:origem => linha_ponto_origem, :destino => linha_ponto_destino)

              horarios.each do |horario|
                linha_ponto_linha_ponto.horarios.build(:partida => horario[0], :chegada => horario[1], :via => horario[2])
              end

              linha_ponto_linha_ponto.save!
            end
          end
        end
      end
    end

    puts "Horarios criados"
  end

  desc "TODO"
  task itinerarios: :environment do
    Linha.all.each do |linha|
      begin
        itinerarios = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/Soap/BuscaItinerarios'), :linha => linha.codigo.to_s)
        puts itinerarios if itinerarios.code != '200'
      end while itinerarios.code != '200'

      itinerarios_ida = JSON.parse(itinerarios.body)['ida'].map { |e| { :nome => e['Nome'], :sentido => e['Sentido'].to_f, :lat => e['Lat'].to_f, :lng => e['Lng'].to_f, :linha => linha } }
      itinerarios_volta = JSON.parse(itinerarios.body)['volta'].map { |e| { :nome => e['Nome'], :sentido => e['Sentido'].to_f, :lat => e['Lat'].to_f, :lng => e['Lng'].to_f, :linha => linha } }

      Itinerario.create!(itinerarios_ida)
      Itinerario.create!(itinerarios_volta)
    end

    puts "Itinerários criados"
  end

end
