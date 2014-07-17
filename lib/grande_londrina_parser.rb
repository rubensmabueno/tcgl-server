module GrandeLondrinaParser
  def self.position(line)
    positions = []
    positionsClient = JSON.parse( RestClient.post 'http://site.tcgrandelondrina.com.br:8082/soap/buscamapa',
                                                 :idLinha => line.code ).values.first.split('&').each_slice(6).to_a

    positionsClient.each_with_index do |position, index|
      unless position.size < 4
        attributes = { :from => position[1].split("-->").last,
                       :to => position[2].split("Indo para: ").last,
                       :lat => position[3].to_f,
                       :lng => position[4].to_f,
                       :bus => index,
                       :line_id => line.id }

        positions << Position.new(attributes)
        PositionLogWorker.perform_async(attributes)
      end
    end

    positions
  end

  def self.search_line(type_line)
    params = {'buscarlinha' => type_line.name,
              'rnd' => '0.180445113684982060'}

    begin
      lines_params = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/Soap/BuscarLinhas'), params)

      if lines_params.code != '200'
        puts lines_params.code
        sleep(5)
      end
    end while lines_params.code != '200'

    lines_params = JSON.parse(lines_params.body).first['valor'].
        map { |e| { :code => e.split(' - ').first,
                    :name => ( e.split(' - ')[1..-1].join(' - ') ) } }

    lines_params
  end

  def self.search_stops(line, day)
    params = {'pLinha' => line.code,
              'pDia' => day.id}

    begin
      pontos = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/Soap/BuscarPontos'), params)
      if pontos.code != '200'
        puts pontos.code
        sleep(5)
      end
    end while pontos.code != '200'

    JSON.parse(pontos.body).first['valor'].
        map { |e| { :code => e.split(' - ').first,
                    :name => ( e.split(' - ')[1..-1].join(' - ') ) }}
  end

  def self.search_schedules(line, day, stop_from, stop_to)
    params = {:idLinha => line.code,
              :idDia => day.id,
              :idLinhaO => stop_from.code,
              :idLinhaD => stop_to.code}
    schedules = []

    begin
      request = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/soap/BuscaHorarios'), params)
      if request.code != '200'
        puts request.code
        sleep(5)
      end
    end while request.code != '200'

    doc = Nokogiri::HTML(request.body)

    doc.css('table.tabHoraria tr.trHorariaPar, table.tabHoraria tr.trHorariaImpar').each do |row_horario|
      contentSchedule = row_horario.css('td.tdHoraria').map { |e| e.content }
      schedules << contentSchedule unless contentSchedule.blank?
    end

    schedules.map { |schedule| { :departure => schedule[0],
                                 :arrive => schedule[1],
                                 :via => schedule[2] } }
  end

  def self.search_itinerary(line)
    begin
      itineraries = Net::HTTP.post_form(URI.parse('http://site.tcgrandelondrina.com.br:8082/Soap/BuscaItinerarios'), :linha => line.code.to_s)

      if itineraries.code != '200'
        puts request.code
        sleep(5)
      end
    end while itineraries.code != '200'

    itineraries_from = JSON.parse(itineraries.body)['ida'].map.with_index { |e, index| { :name => e['Nome'],
                                                                                         :to => e['Sentido'].to_f,
                                                                                         :lat => e['Lat'].to_f,
                                                                                         :lng => e['Lng'].to_f,
                                                                                         :order => index.to_f,
                                                                                         :line_id => line.id } }

    itineraries_to = JSON.parse(itineraries.body)['volta'].map.with_index { |e, index| { :name => e['Nome'],
                                                                                         :to => e['Sentido'].to_f,
                                                                                         :lat => e['Lat'].to_f,
                                                                                         :lng => e['Lng'].to_f,
                                                                                         :order => index.to_f,
                                                                                         :line_id => line.id } }
    [ itineraries_from, itineraries_to ]
  end
end
